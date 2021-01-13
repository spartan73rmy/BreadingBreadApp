import 'package:bread_delivery/Home/homePage.dart';
import 'package:bread_delivery/Login/login.dart';

class Routes {
  static dynamic routes = {
    '/Home': (context) => HomePage("Pan"),
    '/Login': (context) => Login(),
  };
}
