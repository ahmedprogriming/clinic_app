part of 'add_patient_cubit.dart';

@immutable
sealed class AddPatientState {
   final String? selectedGender;

  const AddPatientState({
    this.selectedGender,
  });
}

final class AddPatientInitial extends AddPatientState {
const AddPatientInitial({
    super.selectedGender,
  });
}
final class AddPatientLoading extends AddPatientState {
  AddPatientLoading({super.selectedGender});
}
final class AddPatientSuccess extends AddPatientState {
  AddPatientSuccess({super.selectedGender});
}
final class AddPatientFailure extends AddPatientState {
  final String errMessage;

  AddPatientFailure(this.errMessage,{super.selectedGender});
}

