import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:convert';
import 'package:bread_delivery/BLOC/Store/bloc/store_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Entities/storeQr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class StoreCard extends StatefulWidget {
  final Store data;
  final bool isAdmin;
  final int idPath;

  StoreCard(
    this.data,
    this.isAdmin,
    this.idPath, {
    Key key,
  }) : super(key: key);

  @override
  _StoreCardState createState() =>
      _StoreCardState(this.data, this.isAdmin, this.idPath);
}

class _StoreCardState extends State<StoreCard> {
  final Store data;
  final bool isAdmin;
  final int idPath;
  _StoreCardState(this.data, this.isAdmin, this.idPath);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(Icons.store),
        title: RichText(
            text: TextSpan(
                text: 'Nombre: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(Colors.black.value)),
                children: <TextSpan>[
              TextSpan(
                  text: '${data.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(Colors.black.value)))
            ])),
        onTap: () async {
          if (isAdmin) {
            _onShare(context);
          } else {}
        },
        onLongPress: () async {
          if (isAdmin) {
            //If is valid add to list else return
            alertInputDiag(context, "Editar Tienda", "Nombre de la tienda",
                    data.name, "Nombre para la tienda",
                    keyboard: TextInputType.text)
                .then((value) {
              if (value == null) return;
              bool isValid = value != null;
              if (isValid) {
                _editStore(widget.data.id, value);
              }
            });
          }
        },
      ),
      new Divider(
        height: 2.0,
      ),
    ])));
  }

  _onShare(BuildContext context) async {
    String dataQr = jsonEncode(StoreQr(data.id));
    ByteData byteData = await QrPainter(
        data: "$dataQr",
        errorCorrectionLevel: QrErrorCorrectLevel.H,
        version: QrVersions.auto,
        gapless: true,
        color: Colors.black,
        // embeddedImage: ,
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(40, 40),
        )).toImageData(100, format: ImageByteFormat.png);

    Uint8List pngBytes = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final path = "${tempDir.path}/qrStore${data.id}.png";
    final file = await new File(path).create();
    final hola = await file.writeAsBytes(pngBytes);

    final RenderBox box = context.findRenderObject();
    List<String> archivos = new List<String>();
    archivos.add(path);

    String text = "Qr ${data.name}";
    String sub = "${data.id}";
    if (path.isNotEmpty) {
      await Share.shareFiles(archivos,
          text: text,
          subject: sub,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          // subject: {subject, Rect.zero},
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  _editStore(int id, String name) async {
    BlocProvider.of<StoreBloc>(context).add(EditStore(id, name));
    BlocProvider.of<StoreBloc>(context).add(GetStores(idPath));
  }
}
