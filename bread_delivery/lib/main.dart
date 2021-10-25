import 'package:bread_delivery/BLOC/Login/bloc/login_bloc.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/promotionViewParams.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:bread_delivery/Services/Cuenta/accountRepository.dart';
import 'package:bread_delivery/Views/CommonUser/registerPage.dart';
import 'package:bread_delivery/Views/CommonUser/usersPage.dart';
import 'package:bread_delivery/Views/Products/productPage.dart';
import 'package:bread_delivery/Views/Promotions/promotionPage.dart';
import 'package:bread_delivery/Views/Qr/qrPage.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSalePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Entities/storePoint.dart';
import 'Views/Home/homePage.dart';
import 'Views/Login/login.dart';
import 'Views/Map/map.dart';
import 'Views/Paths/pathPage.dart';
import 'Views/Stores/storesPage.dart';
import 'Views/UserSales/userSalesPage.dart';

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
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (_) => LoginBloc(AccountRepository()),
          child: Login(),
        ),
        //Configure router
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Routes.LogOut:
              return MaterialPageRoute(builder: (context) => MyApp());
              break;
            case Routes.Login:
              return MaterialPageRoute(builder: (context) => Login());
              break;
            case Routes.Home:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => HomePage("Pan", isAdmin));
              break;
            case Routes.Paths:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => PathsPage("Rutas", isAdmin));
              break;
            case Routes.UserSales:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) =>
                      UserSalesPage("Rutas de venta", isAdmin));
              break;
            //TODO definir proceso de venta, se manda llamar desde QRScan
            case Routes.Sale:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) =>
                      UserSalesPage("Rutas de venta", isAdmin));
              break;
            //TODO Este proceso es de ventas de prueba
            case Routes.SalePage:
              return MaterialPageRoute(builder: (context) => SalePage());
            case Routes.Stores:
              StoreViewParams params = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => StoresPage("Tiendas", params));
              break;
            case Routes.Map:
              List<StorePoint> points = settings.arguments;
              return MaterialPageRoute(builder: (context) => MapArea(points));
              break;
            case Routes.Register:
              return MaterialPageRoute(
                  builder: (context) => RegisterUserPage("Registro"));
              break;
            case Routes.User:
              return MaterialPageRoute(
                  builder: (context) => UserPage("Usuarios"));
              break;
            case Routes.Qr:
              List<Store> storesInRoute = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => QrPage("Lector QR", storesInRoute));
              break;
            case Routes.Product:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  builder: (context) => ProductsPage('Productos', isAdmin));
              break;
            case Routes.Promotions:
              PromotionViewParams pvp = settings.arguments;
              bool isAdmin = pvp.isAdmin;
              Product product = pvp.producto;
              return MaterialPageRoute(
                  builder: (context) =>
                      PromotionsPage('Promociones', isAdmin, product));
              break;
          }
          return MaterialPageRoute(builder: (context) => Login());
        });
  }
}
