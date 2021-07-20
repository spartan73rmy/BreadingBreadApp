import 'package:bread_delivery/BLOC/Paths/bloc/paths_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PathCard extends StatefulWidget {
  final Path data;
  final bool isAdmin;
  PathCard(this.data, this.isAdmin, {Key key}) : super(key: key);

  @override
  _PathCardState createState() => _PathCardState(this.data, this.isAdmin);
}

class _PathCardState extends State<PathCard> {
  final Path data;
  final bool isAdmin;
  _PathCardState(this.data, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: data.selected
            ? Icon(Icons.not_interested)
            : Icon(Icons.event_available),
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
        subtitle: RichText(
            text: TextSpan(
          text: data.selected ? 'Seleccionado' : 'Disponible',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(Colors.black45.value)),
        )),
        onTap: () async {
          if (isAdmin) {
            //Si es admin ver tiendas
            Navigator.pushNamed(context, Routes.Stores,
                arguments: StoreViewParams(data.id, isAdmin));
          } else {
            //TODO si es usuario enviar como seleccionado y redirigir a home
            // Navigator.pushNamed(context, "/Home",
            //     arguments: StoreViewParams(data.id, isAdmin));
          }
        },
        onLongPress: () async {
          if (isAdmin) {
            //If is valid add to list else return
            alertInputDiag(context, "Editar Ruta", "Nombre de la ruta",
                    data.name, "Nombre para la ruta",
                    keyboard: TextInputType.text)
                .then((value) {
              if (value == null) return;
              bool isValid = value != null;
              if (isValid) {
                _editPath(widget.data.id, value);
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

  _editPath(int id, String name) async {
    BlocProvider.of<PathsBloc>(context).add(EditPath(id, name));
    BlocProvider.of<PathsBloc>(context).add(GetPaths());
  }
}
