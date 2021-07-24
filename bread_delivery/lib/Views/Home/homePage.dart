import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:bread_delivery/CommonWidgets/drawerContent.dart';
import 'package:bread_delivery/CommonWidgets/drawerAdmin.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  HomePage(this.title, this.isAdmin, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _isAdmin() {
    if (isAdmin == null) {
      setState(() {
        isAdmin = widget.isAdmin;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Background(),
      Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        drawer: DrawerContent(isAdmin: isAdmin),
        appBar: AppBar(
          title: Text('¡Bienvenido ' + this.widget.title + "!"),
          toolbarHeight: 80,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0XFF714012), Color(0XFFC26410)])),
          ),
        ),
        body: Builder(builder: (context) {
          return DrawerAdmin(isAdmin: isAdmin);
        }),
      )
    ]);
  }
}
