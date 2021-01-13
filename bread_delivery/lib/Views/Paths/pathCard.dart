import 'package:bread_delivery/BLOC/Paths/bloc/paths_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PathCard extends StatefulWidget {
  final Path data;
  PathCard(this.data, {Key key}) : super(key: key);

  @override
  _PathCardState createState() => _PathCardState(this.data);
}

class _PathCardState extends State<PathCard> {
  final Path data;

  _PathCardState(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: const Icon(Icons.archive),
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
          //TODO ver tiendas de la ruta si es admin
          //TODO si es usuario enviar como seleccionado
        },
        onLongPress: () async {
          //If is valid add to list else return
          alertInputDiag(
                  context,
                  "Editar Ruta",
                  "Introduce el nombre de la ruta",
                  data.name,
                  "Introduce un nombre para la ruta",
                  keyboard: TextInputType.text)
              .then((value) {
            if (value == null) return;
            bool isValid = value != null;
            if (isValid) {
              _editPath(widget.data.id, value);
              //TODO add edit path si es admin
            }
          });
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
