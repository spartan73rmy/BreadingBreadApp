import 'dart:convert';

import 'package:bread_delivery/CommonWidgets/alert.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Entities/storeQr.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class QrScan extends StatefulWidget {
  final String title;
  final UserSaleViewParams currentSale;
  QrScan(this.title, this.currentSale, {Key key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  bool scanned = true;
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
    if (barcode == null) {
      await alertDiag(context, "Esto no es un QR de una tienda", 'QR Invalido');
      return;
    }

    var scannedStore = StoreQr.fromJson(jsonDecode(barcode));
    var store =
        widget.currentSale.stores.singleWhere((el) => el.id == scannedStore.id);
    if (store != null) {
      widget.currentSale.selectedStore = store;
      Navigator.pushNamed(context, Routes.SalePage,
          arguments: widget.currentSale);
    } else if (scanned) {
      await alertDiag(context, "La tienda no esta en su ruta", 'Tienda ');
      setState(() {
        scanned = false;
      });
    }
  }
}
