import 'package:bread_delivery/BLOC/Login/bloc/login_bloc.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Services/Cuenta/accountRepository.dart';
import 'package:bread_delivery/Views/CommonUser/registerPage.dart';
import 'package:bread_delivery/Views/CommonUser/usersPage.dart';
import 'package:bread_delivery/Views/Qr/qrPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Views/Home/homePage.dart';
import 'Views/Login/login.dart';
import 'Views/Paths/pathPage.dart';
import 'Views/Stores/storesPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bread',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (_) => LoginBloc(AccountRepository()),
          child: Login(),
        ),
        //Configure router
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/Login':
              return MaterialPageRoute(builder: (context) => Login());
              break;
            case '/Home':
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => HomePage("Pan", isAdmin));
              break;
            case '/Path':
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => PathsPage("Rutas", isAdmin));
              break;
            case '/Store':
              StoreViewParams params = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => StoresPage("Tiendas", params));
              break;
            case '/Register':
              return MaterialPageRoute(
                  builder: (context) => RegisterUserPage("Registro"));
              break;
            case '/User':
              return MaterialPageRoute(
                  builder: (context) => UserPage("Usuarios"));
              break;
            case '/Qr':
              return MaterialPageRoute(
                  builder: (context) => QrPage("Lector QR"));
              break;
          }
          return MaterialPageRoute(builder: (context) => Login());
        });
  }
}
