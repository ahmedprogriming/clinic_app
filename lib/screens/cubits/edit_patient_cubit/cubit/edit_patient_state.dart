part of 'edit_patient_cubit.dart';

@immutable
sealed class EditPatientState {
final String? selectedGender;
const EditPatientState({this.selectedGender});
}

final class EditPatientInitial extends EditPatientState {
 const EditPatientInitial({super.selectedGender});
}
final class EditPatientLoding extends EditPatientState {
 const EditPatientLoding({super.selectedGender});
}

final class EditPatienDeletedtLoding extends EditPatientState {
 const EditPatienDeletedtLoding({super.selectedGender});
}
final class EditPatientDataLoaded extends EditPatientState 
{
final  Map<String,dynamic> patientData;

  const EditPatientDataLoaded({required this.patientData,super.selectedGender});

}

final class EditPatientSuccess extends EditPatientState 
{


  const EditPatientSuccess({super.selectedGender});

}


final class EditPatientDeletedSuccess extends EditPatientState 
{


  const EditPatientDeletedSuccess({super.selectedGender});

}
final class EditPatientFialure extends EditPatientState {
 final String erroMessage;

const EditPatientFialure(this.erroMessage,{super.selectedGender});

}