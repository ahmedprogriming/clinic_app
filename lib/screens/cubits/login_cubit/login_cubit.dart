import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());
bool rememberMe=false;

void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(LoginInitial(rememberMe: rememberMe));
  }

  // Load saved credentials on screen startup
  Future<Map<String, dynamic>> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isRemembered = prefs.getBool('remember_me') ?? false;
    final String savedEmail = prefs.getString('saved_email') ?? '';

    rememberMe = isRemembered;
    emit(LoginInitial(rememberMe: rememberMe));

    return {
      'rememberMe': isRemembered,
      'email': savedEmail,
    };
  }

  Future<void> loginAuth(String email, String password) async {
   
    emit(LoginLoading(rememberMe: rememberMe));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Persist or clear credentials
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setBool('remember_me', true);
        await prefs.setString('saved_email', email);
      } else {
        await prefs.remove('remember_me');
        await prefs.remove('saved_email');
      }
      emit(LoginSuccess(rememberMe: rememberMe));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'invalid-credential') {
        emit(LoginFailure(errMessage:  'البريد الإلكتروني أو كلمة المرور غير صحيحة',rememberMe: rememberMe) );
      } else if (ex.code == 'invalid-email') {
          emit(LoginFailure(errMessage: 'البريد الإلكتروني غير صحيح',rememberMe: rememberMe));
      } else if (ex.code == 'user-disabled') {
          emit(LoginFailure(errMessage: 'هذا الحساب تم تعطيله',rememberMe: rememberMe));
      } else if (ex.code == 'network-request-failed') {
        emit(LoginFailure(errMessage: 
          'حدث خطأ في الاتصال بالإنترنت، يرجى المحاولة مرة أخرى.',rememberMe: rememberMe
        ));
      } else {
        emit(LoginFailure(errMessage:  ex.message ??  'حدث خطأ، يرجى المحاولة مرة أخرى.',rememberMe: rememberMe));
      }
    } on Exception catch (ex) {
      emit(LoginFailure(errMessage:  'حدث خطأ، يرجى المحاولة مرة أخرى.',rememberMe: rememberMe));
    }
  }
}
