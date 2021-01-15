import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/user.dart';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Http/validationErrorHandler.dart';
import 'package:bread_delivery/Services/User/userRepository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserLogic logic;
  UserBloc(this.logic) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUsers) {
      yield UsersLoading();
      try {
        var users = await logic.fetchUsersList();
        if (users != null) {
          yield UsersLoaded(users);
        }
        yield UsersLoaded(List<User>());
      } catch (e) {
        if (e is MyException && e != null) yield UserError(e);
        yield UsersLoaded(List<User>());
      }
    }

    if (event is AddUser) {
      yield UsersLoading();
      try {
        await logic.addUser(event.user);
        yield UserOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield UserError(e);
        if (e is ErrorV && e != null) yield UserErrorV(e);
        yield UserInitial();
      }
    }
    if (event is EditUser) {
      yield UsersLoading();
      try {
        // await logic.editUser(event.id, event.name);
        yield UserOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield UserError(e);
        yield UserInitial();
      }
    }

    if (event is DeleteUser) {
      yield UsersLoading();
      try {
        await logic.deleteUser(event.id);
        yield UserOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield UserError(e);
        yield UsersLoaded(List<User>());
      }
    }

    if (event is ApproveUser) {
      yield UsersLoading();
      try {
        // await logic.deleteUser(event.id);
        yield UserOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield UserError(e);
        yield UsersLoaded(List<User>());
      }
    }
  }
}
