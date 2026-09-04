import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit() : super(AddPatientInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? selectedGender;

  void changeGender(String? gender) {
    selectedGender = gender;

    emit(AddPatientInitial(selectedGender: selectedGender));
  }

  Future<void> addPatient({
    required String patientname,
    required String numberphone,
    required String address,
    required String gander,
    required int age,
  }) async {
    emit(AddPatientLoading(selectedGender: selectedGender));

    try {
      await firestore.collection('Patients').add({
        'patientname': patientname,
        'numberphone': numberphone,
        'age': age,
        'gander': gander,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AddPatientSuccess(selectedGender: selectedGender));
    } catch (e) {
      emit(AddPatientFailure( 'حدث خطأ، يرجى المحاولة مرة أخرى.', selectedGender: selectedGender));
    }
  }

  void clearGender() {
    selectedGender = null;

    emit(const AddPatientInitial(selectedGender: null));
  }
}
