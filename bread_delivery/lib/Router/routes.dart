import 'package:bread_delivery/Views/Home/homePage.dart';
import 'package:bread_delivery/Views/Login/login.dart';
import 'package:bread_delivery/Views/Paths/pathPage.dart';

class Routes {
  static dynamic routes = {
    '/Home': (context) => HomePage("Pan"),
    '/Login': (context) => Login(),
    '/Path': (context) => PathsPage("Rutas"),
  };
}
