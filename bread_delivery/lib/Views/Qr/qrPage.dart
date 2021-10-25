import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Views/Qr/qrScan.dart';
import 'package:flutter/material.dart';

class QrPage extends StatefulWidget {
  final String title;
  final UserSaleViewParams currentSale;
  QrPage(this.title, this.currentSale, {Key key}) : super(key: key);

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return QrScan(widget.title, widget.currentSale);
  }
}
