part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLogin extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {
  final UserToken token;

  SuccessLogin(this.token);
}

class ErrorLogin extends LoginState {
  final MyException e;
  @override
  String toString() {
    return e.toString();
  }

  ErrorLogin(this.e);
}
