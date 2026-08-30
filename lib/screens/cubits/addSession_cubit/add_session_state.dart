part of 'add_session_cubit.dart';

@immutable
sealed class AddSessionState {
 final String? selectedStateSessionType;
 final    String? secetedStateSessionState;
const  AddSessionState({this.selectedStateSessionType,this.secetedStateSessionState});
}

final class AddSessionInitial extends AddSessionState {
 const AddSessionInitial(
    {super.selectedStateSessionType,super.secetedStateSessionState});
}
final class AddSessionLoading extends AddSessionState {
   const AddSessionLoading({super.selectedStateSessionType,super.secetedStateSessionState});
}
final class AddSessionSuccess extends AddSessionState {
 const  AddSessionSuccess({super.selectedStateSessionType,super.secetedStateSessionState});
}
final class AddSessionFailure extends AddSessionState {
  final String erroMessage;

const  AddSessionFailure({super.selectedStateSessionType,super.secetedStateSessionState,required this.erroMessage});
}