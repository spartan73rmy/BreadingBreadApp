part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UsersLoading extends UserState {}

class UserError extends UserState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  UserError(this.e);
}

class UserErrorV extends UserState {
  final ErrorV e;

  @override
  String toString() {
    return e.toString();
  }

  UserErrorV(this.e);
}

class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded(this.users);
}

class UserOperationCompleted extends UserState {}
