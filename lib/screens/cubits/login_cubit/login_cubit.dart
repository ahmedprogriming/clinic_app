import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> LoginAuth(String email, String password) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'invalid-credential') {
        emit(LoginFailure(errMessage: 'البريد الإلكتروني أو كلمة المرور غير صحيحة') );
      } else if (ex.code == 'invalid-email') {
          emit(LoginFailure(errMessage:'البريد الإلكتروني غير صحيح'));
      } else if (ex.code == 'user-disabled') {
          emit(LoginFailure(errMessage: 'هذا الحساب تم تعطيله'));
      } else if (ex.code == 'network-request-failed') {
        emit(LoginFailure(errMessage:
          'حدث خطأ في الاتصال بالإنترنت، يرجى المحاولة مرة أخرى.',
        ));
      } else {
        emit(LoginFailure(errMessage: ex.message ?? ex.code));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errMessage:  'حدث خطأ، حاول مرة أخرى'));
    }
  }
}
