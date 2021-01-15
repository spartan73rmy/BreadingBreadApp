import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../Entities/userToken.dart';
import '../../../Services/Local/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        if (token is UserToken && token != null) {
          Auth.setUserToket(await SharedPreferences.getInstance(), token);
          yield SuccessLogin(token);
        }
        yield InitialLogin();
      } catch (e) {
        if (e is MyException && e != null) {
          yield ErrorLogin(e);
        } else {
          yield InitialLogin();
        }
      }
    }
  }
}
