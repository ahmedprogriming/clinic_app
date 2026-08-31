import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());
bool remmberMe=false;

void selectedRemmberme(bool value )
{
  remmberMe=value;
  emit(LoginInitial(rememberMe:  remmberMe ));
}

  Future<void> LoginAuth(String email, String password) async {
   
    emit(LoginLoading(rememberMe: remmberMe));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess(rememberMe: remmberMe));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'invalid-credential') {
        emit(LoginFailure(errMessage:  'البريد الإلكتروني أو كلمة المرور غير صحيحة',rememberMe: remmberMe) );
      } else if (ex.code == 'invalid-email') {
          emit(LoginFailure(errMessage: 'البريد الإلكتروني غير صحيح',rememberMe: remmberMe));
      } else if (ex.code == 'user-disabled') {
          emit(LoginFailure(errMessage: 'هذا الحساب تم تعطيله',rememberMe: remmberMe));
      } else if (ex.code == 'network-request-failed') {
        emit(LoginFailure(errMessage: 
          'حدث خطأ في الاتصال بالإنترنت، يرجى المحاولة مرة أخرى.',rememberMe: remmberMe
        ));
      } else {
        emit(LoginFailure(errMessage:  ex.message ?? ex.code,rememberMe: remmberMe));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errMessage:  'حدث خطأ، حاول مرة أخرى',rememberMe: remmberMe));
    }
  }
}
