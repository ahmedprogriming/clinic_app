import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_patient_state.dart';

class EditPatientCubit extends Cubit<EditPatientState> {
  EditPatientCubit() : super(EditPatientInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

    String? selectedGender;

  void changeGender(String? gender) {
    selectedGender = gender;

    emit(EditPatientInitial(selectedGender: selectedGender));
  }

  Future<void> editPatient({
    required String docId, // معرّف المستند المراد تعديله
    required String patientname,
    required String numberphone,
    required String address,
    required String gander,
    required int age,
  }) async {
    emit(EditPatientLoding(selectedGender: selectedGender));

    try {
      await firestore.collection('Patients').doc(docId).update({
        'patientname': patientname,
        'numberphone': numberphone,
        'age': age,
        'gander': gander,
        'address': address,
        'updatedAt': FieldValue.serverTimestamp(), // تحديث وقت التعديل
      });

      emit(EditPatientSuccess(selectedGender: selectedGender));
    } catch (e) {
      emit(EditPatientFialure(e.toString(), selectedGender: selectedGender));
    }
  }

  void clearGender() {
    selectedGender = null;

    emit(const EditPatientInitial(selectedGender: null));
  }

  // دالة جلب بيانات المريض لتعبئة الحقول
  Future<void> getPatientData(String docId) async {
    emit(EditPatientLoding(selectedGender: selectedGender));
    try {
      DocumentSnapshot doc =
          await firestore.collection('Patients').doc(docId).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        // تعيين قيمة الجنس المحفوظة
        selectedGender = data['gander']; 

        emit(EditPatientDataLoaded(
          patientData: data,
          selectedGender: selectedGender,
        ));
      } else {
        emit(EditPatientFialure('المريض غير موجود', selectedGender: selectedGender));
      }
    } catch (e) {
      emit(EditPatientFialure(e.toString(), selectedGender: selectedGender));
    }
  }

  
  // deleted patient

  Future<void> deletepatient({required String patientId}) async {
    emit(EditPatienDeletedtLoding());

    try {
      await firestore.collection('Patients').doc(patientId).delete();
      emit(EditPatientDeletedSuccess(selectedGender: selectedGender));
    } catch (e) {
      emit(EditPatientFialure( e.toString(),selectedGender: selectedGender));
    }
  }
  
}
