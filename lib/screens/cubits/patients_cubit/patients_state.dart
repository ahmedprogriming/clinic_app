part of 'patients_cubit.dart';

@immutable
sealed class PatientsState {}

final class PatientsInitial extends PatientsState {}
final class PatientsLoding extends PatientsState {}
final class PatientsSuccess extends PatientsState
 {
  List<PatientsModel> patientsList = [];
  PatientsSuccess({required this.patientsList});
 }
final class PatientsFailure extends PatientsState 
{
final String errMessage;
PatientsFailure({required this.errMessage});
}