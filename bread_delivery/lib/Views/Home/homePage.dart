import 'package:bread_delivery/CommonWidgets/drawerContent.dart';
import 'package:bread_delivery/Enums/Routes.dart';
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
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerContent(isAdmin: isAdmin),
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () async {
              Navigator.of(context).pushNamed(Routes.Qr);
            },
          )
        ],
      ),
      body: Builder(builder: (context) {
        return Container();
      }),
      persistentFooterButtons: <Widget>[
        FloatingActionButton.extended(
          icon: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
          label: Text("Pedido"),
        )
      ],
    );
  }
}
