import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clinic_app/model/sessions_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'edit_session_state.dart';

class EditSessionCubit extends Cubit<EditSessionState> {
  EditSessionCubit() : super(EditSessionInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? _sessionSubscription;

  Future<String> uploadImageToCloudinary(File imageFile) async {
    const String cloudName = 'rb5m40f3';
    const String uploadPreset = 'clinic_preset';

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final jsonResponse = jsonDecode(String.fromCharCodes(responseData));
      return jsonResponse['secure_url']; // الرابط المباشر
    } else {
      throw Exception('فشل رفع الصورة إلى Cloudinary');
    }
  }

  Future<void> getSessiondata(String sessionId) async {
    if (isClosed) return;
    emit(EditSessionLoading());

    await _sessionSubscription?.cancel();

    _sessionSubscription = firestore
        .collection('Sessions')
        .doc(sessionId)
        .snapshots()
        .listen(
          (doc) async {
            // حماية فورية عند وصول أي تحديث من الستريم
            if (isClosed) return;

            if (doc.exists && doc.data() != null) {
              try {
                final session = SessionModel.fromFirestore(doc);

                String patientName = 'غير محدد';

                // جلب اسم المريض
                if (session.patientID != null) {
                  final patientDoc = await session.patientID!.get();
                  if (isClosed) return; // فحص بعد العملية غير المتزامنة
                  if (patientDoc.exists && patientDoc.data() != null) {
                    final patientData =
                        patientDoc.data() as Map<String, dynamic>;
                    patientName = patientData['patientname'] ?? 'غير معروف';
                  }
                }

                // جلب روابط الصور بأمان
                List<dynamic> urls = [];
                for (var item in session.images) {
                  if (isClosed) return;

                  // 1. إذا كان رابطاً نصياً قادماً من Cloudinary مباشرة
                  if (item is String) {
                    if (item.trim().isNotEmpty) {
                      urls.add(item.trim());
                    }
                  }
                  // 2. إذا كان مرجع مستند في Firestore (DocumentReference)
                  else if (item is DocumentReference) {
                    final imgDoc = await item.get();
                    if (isClosed) return;
                    if (imgDoc.exists && imgDoc.data() != null) {
                      final imgData = imgDoc.data() as Map<String, dynamic>;
                      final url =
                          imgData['url'] ??
                          imgData['imageUrl'] ??
                          imgData['imagePath'];
                      if (url != null) urls.add(url.toString());
                    }
                  }
                }

                if (!isClosed) {
                  emit(
                    EditSessionLoadedData(
                      SessionData: session,
                      patientName: patientName,
                      imageUrls: urls,
                    ),
                  );
                }
              } catch (e) {
               
                if (!isClosed) {
                  emit(EditSessionFailure(erroMessage: e.toString()));
                }
              }
            } else {
              if (!isClosed) {
                emit(EditSessionFailure(erroMessage: 'الجلسة غير موجودة'));
              }
            }
          },
          onError: (error) {
            if (!isClosed) {
              emit(
                EditSessionFailure(
                  erroMessage:
                      'حدث خطأ أثناء جلب البيانات، يرجى المحاولة لاحقاً.',
                ),
              );
            }
          },
        );
  }

  // تحديث بيانات الجلسة
  Future<void> updateSession({
    required String sessionId,
    required DateTime date,
    required String time,
    required String doctorName,
    required String places,
    required String notes,
    required String state,
    required String type,
    required List<File> imageFiles,
    required List<dynamic> currentImageUrls,
    required List<dynamic> originalImages,
  }) async {
    if (isClosed) return;
    emit(EditSessionLoading());

    try {
      // 1. تحديد وحذف وثائق الصور التي تمت إزالتها من الواجهة
      for (var item in originalImages) {
        if (item is DocumentReference) {
          final doc = await item.get();
          if (doc.exists && doc.data() != null) {
            final data = doc.data() as Map<String, dynamic>;
            final url = data['imageUrl'] ?? data['url'] ?? data['imagePath'];

            // إذا لم يعد الرابط موجوداً في القائمة المتبقية، احذف الوثيقة من SessionImages
            if (url != null && !currentImageUrls.contains(url.toString())) {
              await item.delete();
            }
          }
        }
      }
      // 2. تجميع الروابط المتبقية مع الصور الجديدة
      final List<dynamic> updatedImages = List<dynamic>.from(currentImageUrls);

      // 3. رفع الصور الجديدة وإضافتها لـ SessionImages

      for (final file in imageFiles) {
        // رفع الملف إلى Cloudinary واسترجاع الرابط المباشر
        final String downloadUrl = await uploadImageToCloudinary(file);

        // إضافة سجل الصورة في collection الـ SessionImages
        final docRef = await firestore.collection('SessionImages').add({
          'imageUrl': downloadUrl,
          'uploadedAt': FieldValue.serverTimestamp(),
        });

        updatedImages.add(docRef);
      }
      await firestore.collection('Sessions').doc(sessionId).update({
        'date': Timestamp.fromDate(date),
        'time': time,
        'doctorName': doctorName,
        'places': places,
        'notes': notes,
        'state': state,
        'type': type,
        'images': updatedImages,
      });
      if (!isClosed) emit(SessionUpdatedSuccess());
    } catch (e) {
      if (!isClosed)
        emit(
          EditSessionFailure(erroMessage: 'حدث خطأ، يرجى المحاولة مرة أخرى.'),
        );
    }
  }

  // حذف الجلسة
  Future<void> deleteSession({required String sessionId}) async {
    if (isClosed) return;
    emit(EditSessionLoading());

    try {
      await firestore.collection('Sessions').doc(sessionId).delete();
      if (!isClosed) emit(SessionDeletedSuccess());
    } catch (e) {
      if (!isClosed)
        emit(
          EditSessionFailure(erroMessage: 'حدث خطأ، يرجى المحاولة مرة أخرى.'),
        );
    }
  }

  // هذا التابع هو الأهم لمنع تسريب الذاكرة وإيقاف الـ Stream فور الخروج من الشاشة
  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
