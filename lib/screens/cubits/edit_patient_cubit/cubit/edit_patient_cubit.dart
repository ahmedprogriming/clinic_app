import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_patient_state.dart';

class EditPatientCubit extends Cubit<EditPatientState> {
  EditPatientCubit() : super(EditPatientInitial());
}
