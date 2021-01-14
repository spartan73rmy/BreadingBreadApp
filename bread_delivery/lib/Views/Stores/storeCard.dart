import 'package:bread_delivery/BLOC/Store/bloc/store_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  _editStore(int id, String name) async {
    BlocProvider.of<StoreBloc>(context).add(EditStore(id, name));
    BlocProvider.of<StoreBloc>(context).add(GetStores(idPath));
  }
}
