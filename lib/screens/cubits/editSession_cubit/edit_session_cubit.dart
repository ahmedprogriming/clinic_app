import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinic_app/model/sessions_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_session_state.dart';

class EditSessionCubit extends Cubit<EditSessionState> {
  EditSessionCubit() : super(EditSessionInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<DocumentSnapshot>? _sessionSubscription;
  Future<void> getSessiondata(String sessionId) async {
    emit(EditSessionLoading());
    // Cancel existing stream before starting a new one
    _sessionSubscription?.cancel();

    _sessionSubscription = firestore
        .collection('Sessions')
        .doc(sessionId)
        .snapshots()
        .listen((doc) async {
          if (doc.exists && doc.data() != null) {
            try {
              final session = SessionModel.fromFirestore(doc);

              String patientName = 'غير محدد';

              // جلب اسم المريض من الـ DocumentReference مباشرة
              if (session.patientID != null) {
                final patientDoc = await session.patientID!.get();
                if (patientDoc.exists && patientDoc.data() != null) {
                  final patientData = patientDoc.data() as Map<String, dynamic>;
                  patientName = patientData['patientname'] ?? 'غير معروف';
                }
              }

              // جلب روابط الصور من مراجع المستندات
              List<String> urls = [];
              for (var ref in session.images) {
                final imgDoc = await ref.get();
                if (imgDoc.exists && imgDoc.data() != null) {
                  final imgData = imgDoc.data() as Map<String, dynamic>;
                  final url =
                      imgData['url'] ??
                      imgData['imageUrl'] ??
                      imgData['imagePath'];
                  if (url != null) urls.add(url.toString());
                }
              }

              emit(
                EditSessionLoadedData(
                  SessionData: session,
                  patientName: patientName,
                  imageUrls: urls,
                ),
              );
            } catch (e) {
              emit(EditSessionFailure(erroMessage: e.toString()));
            }
          } else {
            emit(EditSessionFailure(erroMessage: 'الجلسة غير موجودة'));
          }
        },
        onError: (error) {
        emit(EditSessionFailure(erroMessage: error.toString()));
      },
        );

    {}
  }

  //update the session date

  Future<void> updateSession({
    required String sessionId,
    required Map<String, dynamic> updateDate,
  }) async {
    emit(EditSessionLoading());

    try {
      await firestore.collection('Sessions').doc(sessionId).update(updateDate);
      emit(SessionUpdatedSuccess());
    } catch (e) {
      emit(EditSessionFailure(erroMessage: e.toString()));
    }
  }

  // deleted session

  Future<void> deleteSession({required String sessionId}) async {
    emit(EditSessionLoading());

    try {
      await firestore.collection('Sessions').doc(sessionId).delete();
      emit(SessionDeletedSuccess());
    } catch (e) {
      emit(EditSessionFailure(erroMessage: e.toString()));
    }
  }
}
