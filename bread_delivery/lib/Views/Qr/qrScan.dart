import 'package:bread_delivery/CommonWidgets/alert.dart';
import 'package:bread_delivery/Entities/storeQr.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class QrScan extends StatefulWidget {
  final String title;
  QrScan(this.title, {Key key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  bool _checkConfiguration() => true;

  @override
  void initState() {
    super.initState();
    if (_checkConfiguration()) {
      Future.delayed(Duration.zero, () {
        _scan(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Esto vendria siendo una actividad
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _scan(context);
            },
            label: Text("Leer QR"),
            icon: Icon(Icons.qr_code)));
  }

  _scan(BuildContext context) async {
    Permission.camera.request();
    // Permission.storage.request();
    var status = await Permission.camera.status;
    if (status.isLimited) {
      Permission.camera.request();
      //Hacer request de permisos
      Permission.camera.request();
    }

    String barcode = await scanner.scan();
    if (barcode != null) {
      int idStore = StoreQr.decodeString(barcode).id;
      //TODO pasar parametro id de tienda
      if (idStore != 0) Navigator.pushNamed(context, Routes.Sale);

      await alertDiag(
          context, "El codigo Qr no es un codigo valido", 'QR Invalido');
    }
  }
}
