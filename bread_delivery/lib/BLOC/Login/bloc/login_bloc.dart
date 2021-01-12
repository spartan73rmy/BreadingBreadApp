import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../Entities/token.dart';
import '../../../Services/Cuenta/accountRepository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLogin());

  final AccountRepository _repo = AccountRepository();

  LoginBloc get init => LoginBloc();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is DoLogin) {
      yield LoadingLogin();
      try {
        var token = await _repo.login(event.userName, event.password);
        if (token == null) {
          yield ErrorLogin();
        }
        yield SuccessLogin(token);
      } catch (_) {
        yield ErrorLogin();
      }
    }
  }
}
