import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinic_app/model/sessions_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'sessionlist_state.dart';

class SessionlistCubit extends Cubit<SessionlistState> {
  SessionlistCubit() : super(SessionlistInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription? _sessionsSubscription;
  List<SessionModel> _allSessions = [];
  String _currentQuery = '';
  Future<void> getSessionsData(String patientId) async {
    emit(SessionlistLoading());

    // إنشاء مرجع للمريض للبحث عنه داخل حقل PatientID المرجعي
    // إلغاء أي اشتراك قديم قبل بدء اشتراك جديد
    _sessionsSubscription?.cancel();
    DocumentReference patientRef = firestore
        .collection('Patients')
        .doc(patientId);

    // عمل Query لجلب كل الوثائق التي ينتمي حقل PatientID فيها لهذا المريض
    _sessionsSubscription = firestore
        .collection('Sessions')
        .where('patientID', isEqualTo: patientRef)
        
        .snapshots()
        .listen(
          (querySnapshot) {
            _allSessions = querySnapshot.docs
                .map((doc) => SessionModel.fromFirestore(doc))
                .toList();
 _allSessions.sort(((a, b) => a.numberSession.compareTo(b.numberSession)));
            _applyFilter();
          },
          onError: (e) {
            emit(SessionlistFailure(erroMessage: e.toString()));
          },
        );
  }

 // دالة البحث والفلترة
  void searchSessions(String query) {
    _currentQuery = query.trim().toLowerCase();
    _applyFilter();
  }

  void _applyFilter() {
    if (_currentQuery.isEmpty) {
      emit(SessionlistSuccess(
        sessionsList: _allSessions,
        filteredSessionsList: _allSessions,
      ));
      return;
    }

    final filtered = _allSessions.where((session) {
      final sessionNumMatch =
          session.numberSession.toString().contains(_currentQuery);
      final notesMatch =
          session.notes.toLowerCase().contains(_currentQuery);
      final doctorMatch =
          session.nameDoctor.toLowerCase().contains(_currentQuery);

      return sessionNumMatch || notesMatch || doctorMatch;
    }).toList();

    emit(SessionlistSuccess(
      sessionsList: _allSessions,
      filteredSessionsList: filtered,
    ));
  }
}
