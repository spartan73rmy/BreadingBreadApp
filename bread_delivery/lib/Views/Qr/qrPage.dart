import 'package:bread_delivery/BLOC/Qr/bloc/qr_bloc.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Services/Qr/QrRepository.dart';
import 'package:bread_delivery/Views/Qr/qrScan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
        create: (_) => QrBloc(QrRepository()),
        child: QrScan(widget.title, widget.currentSale));
  }
}
