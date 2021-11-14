import 'dart:convert';

import 'package:bread_delivery/BLOC/Qr/bloc/qr_bloc.dart';
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
  bool _checkConfiguration() => true;
  String message = '';
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

          return Container(
            child: Center(
                child: Padding(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20))),
          );
        })),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _scan(context);
            },
            label: Text("Leer QR"),
            icon: Icon(Icons.qr_code)));
  }

  _scan(BuildContext context) async {
    setState(() {
      message = "";
    });
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
      setState(() {
        message = "Esto no es un QR valido";
      });
      return;
    }

    var scannedStore = StoreQr.fromJson(jsonDecode(barcode));

    var store =
        widget.currentSale.stores.where((el) => el.id == scannedStore?.id);

    if (store.isEmpty) {
      setState(() {
        message = 'La tienda no esta en su ruta' +
            '\n\nSi necesita realizar una entrega pida al administrador asignar la tienda a la ruta: ${widget.currentSale.selectedPath.pathName}';
      });
      return;
    }
    var currentStore = store?.first;

    if (currentStore.visited) {
      setState(() {
        message = 'La tienda ya fue visitada' +
            '\n\nYa se realizo una venta en esta tienda';
      });
      return;
    }

    await _determinePosition()
        .then((value) => _setCoordsStore(currentStore.id, value))
        .onError((error, stackTrace) => snackBar(context, error));
    setState(() {
      widget.currentSale.selectedStore = currentStore;
    });
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
