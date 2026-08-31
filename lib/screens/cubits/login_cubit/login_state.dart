part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  final bool rememberMe;
  const LoginState({this.rememberMe = false});
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.rememberMe});
}

final class LoginLoading extends LoginState {
  const LoginLoading({super.rememberMe});
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({super.rememberMe});
}

final class LoginFailure extends LoginState {
  final String errMessage;
  const LoginFailure({required this.errMessage, super.rememberMe});
}