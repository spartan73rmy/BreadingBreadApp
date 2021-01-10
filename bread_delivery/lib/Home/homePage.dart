import '../CommonWidgets/drawerContent.dart';
import '../CommonWidgets/loadingScreen.dart';
import '../Login/login.dart';
import '../Services/conectionService.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  HomePage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading;
  bool isAdmin;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Ping get ping => GetIt.I<Ping>();

  bool isOnline;

  @override
  void initState() {
    isLoading = false;
    isOnline = false;

    super.initState();
    isAdm();
    isConnected();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerContent(
        isAdmin: isAdmin,
      ),
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () async {
              // await uploadData();
            },
          ),
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
        if (isLoading) {
          return LoadingScreen();
        }
        // return ListTempReport();
      }),
      persistentFooterButtons: <Widget>[
        FloatingActionButton.extended(
          icon: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   // MaterialPageRoute(builder: (context) => ImagenPicker()),
            //   // MaterialPageRoute(builder: (context) => AddReport()),
            // );
          },
          label: Text("Agregar Reporte"),
        )
      ],
    );
  }

  // Future<bool> getDataSearch() async {
  //   showLoading();
  //   // _sharedPreferences = await _prefs;
  //   // bool isNotLogged = !Auth.isLogged(_sharedPreferences);
  //   // String authToken = Auth.getToken(_sharedPreferences);
  //   isOnline = await ping.ping();

  //   if (isOnline) {
  //     if (isNotLogged) toLogIn();
  //     var resp = await reportService.getDataSearch(authToken);

  //     if (res.error) {
  //       alertDiag(context, "Error", res.errorMessage);
  //       hideLoading();
  //       return false;
  //     }

  //     setState(() {
  //       busqueda = resp.data;
  //     });

  //     hideLoading();
  //     return true;
  //   } else {
  //     alertDiag(
  //         context, "Error", "Favor de conectarse a internet e iniciar sesion");
  //     hideLoading();
  //     return false;
  //   }
  // }

  Future<void> isAdm() async {
    // _sharedPreferences = await _prefs;

    // setState(() {
    //   isAdmin = Auth.isAdmin(_sharedPreferences);
    // });
  }

  toLogIn() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login("FitoReport")),
    );
  }

  isConnected() async {
    bool l = await ping.ping();
    setState(() {
      isOnline = l;
    });
    isOnline
        ? showSnackBar("Conectado a internet")
        : showSnackBar("Modo sin conexion");
  }

  showSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  hideLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
