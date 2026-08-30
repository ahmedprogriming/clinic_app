part of 'sessionlist_cubit.dart';

@immutable
sealed class SessionlistState {}

final class SessionlistInitial extends SessionlistState {}
final class SessionlistLoading extends SessionlistState {}
final class SessionlistSuccess extends SessionlistState {
final List<SessionModel> sessionsList;
final List<SessionModel> filteredSessionsList;
  SessionlistSuccess({required this.sessionsList,required this.filteredSessionsList});
}
final class SessionlistFailure extends SessionlistState {
  final String erroMessage;

  SessionlistFailure({required this.erroMessage});
}
