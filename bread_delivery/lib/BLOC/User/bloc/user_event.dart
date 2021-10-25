part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetUsers extends UserEvent {
  GetUsers() : super([]);
}

class AddUser extends UserEvent {
  final UserCreate user;

  AddUser(this.user) : super([user]);
}

class EditUser extends UserEvent {
  final String name;
  final int id;

  EditUser(this.id, this.name) : super([name, id]);
}

class DeleteUser extends UserEvent {
  final String userName;

  DeleteUser(this.userName) : super([userName]);
}

class ApproveUser extends UserEvent {
  final String userName;
  ApproveUser(this.userName) : super([userName]);
}
