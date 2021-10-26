import 'dart:convert';

import 'package:bread_delivery/BLOC/Qr/bloc/qr_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alert.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/storeQr.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
        body: BlocListener<QrBloc, QrState>(listener: (context, state) {
          if (state is QrError) snackBar(context, state.toString());

          if (state is QrOperationCompleted) {
            //snackBar(context, state.message);
            Navigator.of(context)
                .pushNamed(Routes.SalePage, arguments: widget.currentSale);
          }
        }, child: BlocBuilder<QrBloc, QrState>(builder: (context, state) {
          if (state is QrLoading) return MessageScreen();

          return Container();
        })),
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
      await _determinePosition()
          .then((value) => _setCoordsStore(store.id, value))
          .onError((error, stackTrace) => snackBar(context, error));
      setState(() {
        widget.currentSale.selectedStore = store;
      });
    } else if (scanned) {
      await alertDiag(context, "La tienda no esta en su ruta", 'Tienda ');
      setState(() {
        scanned = false;
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
          'El servicio de GPS esta desactivado, activelo por favor');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('El permiso fue denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Permiso denegado por siempre, permita el permiso en la configuracion');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: false,
        timeLimit: Duration(seconds: 30));
  }

  Future _setCoordsStore(int id, Position coords) async {
    BlocProvider.of<QrBloc>(context).add(SetCoordsStore(id, coords));
  }
}
