import '../CommonWidgets/drawerContent.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin = true;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
            icon: Icon(Icons.search),
            onPressed: () async {
              //   bool search = await getDataSearch();
              //   if (search)
              //     showSearch(context: context, delegate: Search(busqueda));
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
