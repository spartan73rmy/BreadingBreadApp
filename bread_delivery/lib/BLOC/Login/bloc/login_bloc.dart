import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../Entities/token.dart';
import '../../../Services/Cuenta/accountRepository.dart';
import '../../../Services/Http/networkError.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginLogic logic;

  LoginBloc(this.logic) : super(InitialLogin());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is DoLogin) {
      yield LoadingLogin();
      try {
        var token = await logic.login(event.userName, event.password);
        //TODO add user info to shared preferences
        print(token);
        if (token != null) yield SuccessLogin(token);
        yield InitialLogin();
      } catch (e) {
        yield ErrorLogin(e);
      }
    }
  }
}
