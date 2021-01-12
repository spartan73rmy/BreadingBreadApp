part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLogin extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {
  final Token token;

  SuccessLogin(this.token);
}

class ErrorLogin extends LoginState {}
