part of 'edit_session_cubit.dart';

@immutable
sealed class EditSessionState {}

final class EditSessionInitial extends EditSessionState {}
final class EditSessionLoading extends EditSessionState {}
final class EditSessionLoadedData extends EditSessionState {
  final  SessionModel? SessionData;
final String? patientName;
final List<String> imageUrls; // إضافة روابط الصور
  EditSessionLoadedData( {this.SessionData,this.patientName,this.imageUrls=const[]});
}
final class SessionUpdatedSuccess extends EditSessionState {}
final class SessionDeletedSuccess extends EditSessionState {}
final class EditSessionFailure extends EditSessionState 
{
  final String erroMessage;
  EditSessionFailure({required this.erroMessage});
}