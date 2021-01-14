import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
