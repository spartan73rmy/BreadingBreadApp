import 'package:flutter/material.dart';

class QrScan extends StatefulWidget {
  final String title;
  QrScan(this.title, {Key key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  int cont = 0;
  @override
  void initState() {
    //Esto es por si necesitas inicializar algo, NO puede ser async
    super.initState();
  }

  _incrementar() async {
    setState(() {
      cont++;
      //Esta funcion es por si necesitas cambiar los valores de algo y se muestre en la app
      //Si incremento una variable fuera de setState no se mestra el cambio
      //Si lo hago dentro a medida que cambia su valor, tbm se muestra en la UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Esto vendria siendo una actividad
        appBar: AppBar(
          //Esta es la barrita, ctrl+ shift + espacio y te muestra los parametros
          title: Text(widget.title),
        ),
        body: Container(
          child: Text("$cont"),
        ), //Elimina el container y metes el codigo del lector,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _incrementar();
            },
            label: Text("Hola"),
            icon: Icon(Icons.plus_one)));
  }
}
