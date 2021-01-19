import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class QrScan extends StatefulWidget {
  final String title;
  QrScan(this.title, {Key key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String _scanResult;

  @override
  void initState() {
    //Esto es por si necesitas inicializar algo, NO puede ser async
    super.initState();
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
            child: _scanResult == null
                ? Text('Esperando datos de código')
                : Column(
                    children: [Text('Contenido: $_scanResult')],
                  )), //Elimina el container y metes el codigo del lector,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _scan();
            },
            label: Text("Leer QR"),
            icon: Icon(Icons.qr_code)));
  }

  Future _scan() async {
    Permission.camera.request();
    // Permission.storage.request();
    var status = await Permission.camera.status;
    if (status.isUndetermined) {
      Permission.camera.request();
      //Hacer request de permisos
      Permission.camera.request();
    }

    String barcode = await scanner.scan();
    if (barcode != null) {
      setState(() {
        _scanResult = barcode;
      });
    }
  }
}
