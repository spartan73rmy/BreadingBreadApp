import 'package:bread_delivery/Entities/loginUser.dart';
import '../../Entities/token.dart';
import '../../Services/Http/dioClient.dart';

class AccountRepository {
  static const String url = "Cuenta/";
  DioClient http = DioClient();

  Future<Token> login(String userName, String password) async {
    final credentials = LoginUser(userName, password);
    final response = await http.post(url + "/Ingresar",
        queryParameters: credentials.toJson());
    return Token.fromJson(response.data);
  }
}
