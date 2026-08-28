import 'package:bloc/bloc.dart';
import 'package:clinic_app/model/sessions_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'sessionlist_state.dart';

class SessionlistCubit extends Cubit<SessionlistState> {
  SessionlistCubit() : super(SessionlistInitial());
   final FirebaseFirestore firestore = FirebaseFirestore.instance;

   Future<void> getSessionsData (String patientId) async
   {
    emit(SessionlistLoading());

    try {
      // إنشاء مرجع للمريض للبحث عنه داخل حقل PatientID المرجعي
      
      DocumentReference patientRef =
          firestore.collection('Patients').doc(patientId);

      // عمل Query لجلب كل الوثائق التي ينتمي حقل PatientID فيها لهذا المريض
      QuerySnapshot querySnapshot = await firestore
          .collection('Sessions')
          .where('PatientID', isEqualTo: patientRef)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // تحويل كل مستند إلى كائن SessionModel وتخزينهم في List
        List<SessionModel> sessionsList = querySnapshot.docs
            .map((doc) => SessionModel.fromFirestore(doc))
            .toList();
      

        emit(SessionlistSuccess(
          sessionsList: sessionsList,
         
        ));
      } else {
        emit(SessionlistFailure(erroMessage: 'لا توجد جلسات لهذاالمريض'));
      }
    } catch (e) {
      emit(SessionlistFailure(erroMessage: e.toString()));
    }
   }
}
