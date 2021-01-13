import 'dart:convert';

import '../../Entities/loginUser.dart';
import '../../Services/Http/networkError.dart';
import '../../Entities/token.dart';
import '../../Services/Http/dioClient.dart';

abstract class LoginLogic {
  Future<Token> login(String userName, String password);
  Future<void> logOut(Token token);
}

class AccountRepository extends LoginLogic {
  static const String url = "Cuenta/";
  DioClient http = DioClient();

  @override
  Future<Token> login(String userName, String password) async {
    final credentials = LoginUser(userName, password);
    try {
      final response = await http.post(url + "/Ingresar",
          data: jsonEncode(credentials.toJson()));
      return Token.fromJson(response);
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> logOut(Token token) {
    // TODO: implement logOut, delete in shared preferences and logOut from server
    throw UnimplementedError();
  }
}
