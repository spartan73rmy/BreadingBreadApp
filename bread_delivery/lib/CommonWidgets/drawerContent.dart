import 'package:bread_delivery/Enums/Routes.dart';
import 'package:bread_delivery/Views/Login/login.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatefulWidget {
  final bool isAdmin;
  DrawerContent({this.isAdmin, key}) : super(key: key);

  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  bool isAdmin;

  @override
  void initState() {
    _isAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return drawerContent(context);
  }

  _isAdmin() {
    if (isAdmin == null) {
      setState(() {
        isAdmin = widget.isAdmin;
      });
    }
  }

  Future<void> logOut() async {
    // _sharedPreferences = await _prefs;
    // await Auth.logoutUser(_sharedPreferences);
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Drawer drawerContent(BuildContext context) {
    return Drawer(child: Column(children: _options(context, widget.isAdmin)));
  }

  dynamic _options(BuildContext context, bool isAdmin) {
    if (isAdmin)
      return <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text('Hola\nJose Alberto Espinoza Morelos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ))),
        ListTile(
          leading: Icon(Icons.supervised_user_circle),
          title: Text('Usuarios'),
          subtitle: Text.rich(
            TextSpan(
                text: "Aprobar usuarios nuevos",
                style:
                    TextStyle(color: Color(Colors.black.value), fontSize: 15)),
          ),
          onTap: () {
            Navigator.pushNamed(context, Routes.User);
          },
        ),
        ListTile(
          leading: Icon(Icons.alt_route_rounded),
          title: Text('Rutas'),
          onTap: () {
            Navigator.pushNamed(context, Routes.Paths, arguments: isAdmin);
          },
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text('Tiendas'),
          onTap: () async {
            Navigator.pushNamed(context, Routes.Stores, arguments: isAdmin);
          },
        ),
        ListTile(
          leading: Icon(Icons.breakfast_dining),
          title: Text('Producto'),
          onTap: () async {
            Navigator.pushNamed(context, Routes.Product, arguments: isAdmin);
          },
        ),
        ListTile( //TODO: Cambiar de drawerContent a la vista de Productos
          leading: Icon(Icons.chair),
          title: Text('Promociones'),
          onTap: () async {
            Navigator.pushNamed(context, Routes.Promotions, arguments: isAdmin);
          },
        ),
        ListTile(
          leading: Icon(Icons.satellite),
          title: Text('Ventas'),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: ListTile(
            leading: Icon(Icons.close),
            title: Text('Cerrar Sesion'),
            onTap: () async {},
          ),
        ))
      ];
    else
      return <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text('Hola\nNombre de usuario completo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ))),
        ListTile(
          leading: Icon(Icons.alt_route_rounded),
          title: Text('Ruta'),
          onTap: () async {},
        ),
        ListTile(
          leading: Icon(Icons.qr_code),
          title: Text('Leer QR'),
          onTap: () async {},
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: ListTile(
            leading: Icon(Icons.close),
            title: Text('Cerrar Sesion'),
            onTap: () async {},
          ),
        ))
      ];
  }
}
