import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clinic_app/widget/add_new_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'add_session_state.dart';

class AddSessionCubit extends Cubit<AddSessionState> {
  AddSessionCubit() : super(AddSessionInitial());
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? selectedSessionType;
  String? secetedSessionState;

  void changeSessionSate(String? state) {
    secetedSessionState = state;
    emit(AddSessionInitial(selectedStateSessionType:  selectedSessionType,secetedStateSessionState:  secetedSessionState));
  }

  void changeSessionType(String? type) {
    selectedSessionType = type;
    emit(AddSessionInitial(selectedStateSessionType:  selectedSessionType,secetedStateSessionState:  secetedSessionState));
  }

  Future<String> uploadImageToCloudinary(File imageFile) async {
  const String cloudName = 'rb5m40f3'; 
  const String uploadPreset = 'clinic_preset'; 

  final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

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

  Future<void> addSession({required String patientId,
    required DateTime date,
    required String time,
    required String doctorName,
    required String places,
    required String notes,
    List<File> imageFiles = const []}) async
  {
emit(AddSessionLoading(selectedStateSessionType:  selectedSessionType,secetedStateSessionState:  secetedSessionState));

    try {
      final DocumentReference patientRef =
        _firestore.collection('Patients').doc(patientId);

    // 1. حساب رقم الجلسة
    final countSnapshot = await _firestore
        .collection('Sessions')
        .where('patientID', isEqualTo: patientRef)
        .count()
        .get();

    final int nextSessionNumber = (countSnapshot.count ?? 0) + 1;

    // 2. رفع الصور وحفظها في collection منفصل واستخراج المراجع
    final List<DocumentReference> imageReferences = [];

    for (final file in imageFiles) {
    // رفع الملف إلى Cloudinary واسترجاع الرابط المباشر
      final String downloadUrl = await uploadImageToCloudinary(file);

      // إضافة سجل الصورة في collection الـ SessionImages
      final docRef = await _firestore.collection('SessionImages').add({
        'imageUrl': downloadUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      imageReferences.add(docRef);
    }

    // 3. تخزين بيانات الجلسة مع قائمة مراجع الصور
    await _firestore.collection('Sessions').add({
      'patientID': patientRef,
      'numberSession': nextSessionNumber,
      'type': selectedSessionType,
      'state': secetedSessionState,
      'date': Timestamp.fromDate(date),
      'time': time,
      'doctorName': doctorName,
      'places': places,
      'notes': notes,
      'images': imageReferences, // List<DocumentReference>
      'createdAt': FieldValue.serverTimestamp(),
    });

      emit(AddSessionSuccess(selectedStateSessionType:  selectedSessionType,secetedStateSessionState:  secetedSessionState));
    } catch (e) {
      emit(AddSessionFailure(selectedStateSessionType:  selectedSessionType,secetedStateSessionState:  secetedSessionState,erroMessage: e.toString()));
    }
  }
}
