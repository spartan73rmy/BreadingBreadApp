import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSalePage.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/CommonWidgets/cardHome.dart';
import 'package:bread_delivery/Enums/Routes.dart';

class DrawerAdmin extends StatefulWidget {
  final bool isAdmin;

  const DrawerAdmin({Key key, this.isAdmin}) : super(key: key);

  @override
  _DrawerAdminState createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  bool isAdmin;

  @override
  void initState() {
    _isAdmin();
    super.initState();
  }

  _isAdmin() {
    if (isAdmin == null) {
      setState(() {
        isAdmin = widget.isAdmin;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return drawerContent(context);
  }

  Container drawerContent(BuildContext context) {
    return Container(
        child: Column(children: _options(context, widget.isAdmin)));
  }

  @override
  dynamic _options(BuildContext context, bool isAdmin) {
    return <Widget>[
      Column(children: [
        SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (isAdmin)
                      Column(
                        children: [
                          CardHome('assets/icons/users.png', "Usuarios", () {
                            Navigator.pushNamed(context, Routes.User);
                          }),
                          CardHome('assets/icons/path.png', "Rutas", () {
                            Navigator.pushNamed(context, Routes.Paths,
                                arguments: isAdmin);
                          })
                        ],
                      ),
                    Column(
                      children: [
                        CardHome('assets/icons/store.png', "Tiendas", () {
                          Navigator.pushNamed(context, Routes.Stores,
                              arguments: StoreViewParams(null, isAdmin));
                        }),
                        // CardHome('assets/icons/qr-code.png', "Escanear",
                        //     () => {Navigator.of(context).pushNamed(Routes.Qr)})
                      ],
                    ),
                    Column(
                      children: [
                        CardHome('assets/icons/bread.png', "Producto", () {
                          Navigator.pushNamed(context, Routes.Product,
                              arguments: isAdmin);
                        }),
                        CardHome(
                            'assets/icons/logout.png',
                            "Cerrar sesión",
                            () => Navigator.pushReplacementNamed(
                                context, Routes.LogOut))
                      ],
                    ),
                    Column(
                      //TODO Esto es secundario,Definir estadisticas de ventas
                      children: [
                        CardHome('assets/icons/sale-tag.png', "Ventas", () {
                          Navigator.pushNamed(context, Routes.SalePage);
                        }),
                        CardHome('assets/icons/order.png', "Pedido", () {})
                      ],
                    ),
                  ],
                ))),
        Container(
          //Para que o como se va a definir
          child: Text("Ventas de hoy"),
        ),
        Container(
          child: Container(),
        )
      ])
    ];
  }
}
