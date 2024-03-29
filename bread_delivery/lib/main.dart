import 'package:bread_delivery/BLOC/Login/bloc/login_bloc.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/promotionViewParams.dart';
import 'package:bread_delivery/Entities/InventoryViewParams.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:bread_delivery/Services/Cuenta/accountRepository.dart';
import 'package:bread_delivery/Views/CommonUser/registerPage.dart';
import 'package:bread_delivery/Views/CommonUser/usersPage.dart';
import 'package:bread_delivery/Views/Inventory/inventoryPage.dart';
import 'package:bread_delivery/Views/Products/productPage.dart';
import 'package:bread_delivery/Views/Promotions/promotionPage.dart';
import 'package:bread_delivery/Views/Qr/qrPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Entities/storePoint.dart';
import 'Views/Home/homePage.dart';
import 'Views/Login/login.dart';
import 'Views/Map/map.dart';
import 'Views/Paths/pathPage.dart';
import 'Views/Sale/userSaleRootPage.dart';
import 'Views/Stores/storesPage.dart';
import 'Views/UserSales/userSalesPage.dart';
import 'Views/ActivePaths/activePathsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  Map<int, Color> color = { //no tocar esto
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bread',
        theme: ThemeData(
          primarySwatch: MaterialColor(0XFF674023, color),
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
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.LogOut),
                  builder: (context) => MyApp());
              break;
            case Routes.Login:
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Login),
                  builder: (context) => Login());
              break;
            case Routes.Home:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Home),
                  builder: (context) => HomePage("Pan", isAdmin));
              break;
            case Routes.Paths:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Paths),
                  builder: (context) => PathsPage("Rutas", isAdmin));

            case Routes.UserSales:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.UserSales),
                  builder: (context) =>
                      UserSalesPage("Rutas de venta", isAdmin));
              break;
            case Routes.SalePage:
              UserSaleViewParams params = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.SalePage),
                  builder: (context) => SaleRootPage(params));

            case Routes.Stores:
              StoreViewParams params = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Stores),
                  builder: (context) => StoresPage("Tiendas", params));
              break;
            case Routes.Map:
              List<StorePoint> points = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Map),
                  builder: (context) => MapArea(points));
              break;
            case Routes.Register:
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Register),
                  builder: (context) => RegisterUserPage("Registro"));
              break;
            case Routes.User:
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.User),
                  builder: (context) => UserPage("Usuarios"));
              break;
            case Routes.Qr:
              UserSaleViewParams storesInRoute = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Qr),
                  builder: (context) => QrPage("Lector QR", storesInRoute));
              break;
            case Routes.Product:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Qr),
                  builder: (context) => ProductsPage('Productos', isAdmin));
              break;
            case Routes.Promotions:
              PromotionViewParams pvp = settings.arguments;
              bool isAdmin = pvp.isAdmin;
              Product product = pvp.producto;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Promotions),
                  builder: (context) =>
                      PromotionsPage('Promociones', isAdmin, product));
              break;
            case Routes.ActivePaths:
              bool isAdmin = settings.arguments;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.ActivePaths),
                  builder: (context) =>
                      ActivePathsPage("Rutas activas", isAdmin));
              break;
            case Routes.Inventory:
              InventoryViewParams ivp = settings.arguments;
              bool isAdmin = ivp.isAdmin;
              ActivePath path = ivp.activePath;
              return MaterialPageRoute(
                  settings: RouteSettings(name: Routes.Inventory),
                  builder: (context) =>
                      InventoryPage(path, isAdmin));
              break;
          }

          return MaterialPageRoute(
              settings: RouteSettings(name: Routes.LogOut),
              builder: (context) => MyApp());
        });
  }
}
