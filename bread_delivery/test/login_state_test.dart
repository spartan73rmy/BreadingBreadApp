import 'package:bloc_test/bloc_test.dart';
import 'package:bread_delivery/BLOC/Login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  test("User is Login PRUEBA", () {
    final loginBloc = MockLoginBloc();
    whenListen(loginBloc, loginBloc.stream);

    expect(loginBloc.state, LoginBloc);
  });
}
