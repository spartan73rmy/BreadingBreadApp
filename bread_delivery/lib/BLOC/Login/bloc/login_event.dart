part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent([List props = const []]);
  @override
  List<Object> get props => [];
}

class DoLogin extends LoginEvent {
  final String userName;
  final String password;

  DoLogin(this.userName, this.password) : super([userName, password]);
}
