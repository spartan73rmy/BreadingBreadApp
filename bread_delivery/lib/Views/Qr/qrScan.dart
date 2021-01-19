
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;


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
          child:_scanResult==null ?Text('Esperando datos de código'):Column(
          children: [
            Text('Contenido: $_scanResult')
          ],
          )
        ), //Elimina el container y metes el codigo del lector,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _scan();
            },
            label: Text("Leer QR"),
            icon: Icon(Icons.qr_code)));
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode != null) {
      setState(() {
        _scanResult = barcode;
      });
    }
  }

}
