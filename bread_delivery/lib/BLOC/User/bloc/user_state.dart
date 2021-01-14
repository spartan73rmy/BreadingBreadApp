part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  UserError(this.e);
}

class PathsLoaded extends UserState {
  final List<UserCreate> users;

  PathsLoaded(this.users);
}

class UserOperationCompleted extends UserState {}
