import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/path.dart';

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
                fontWeight: FontWeight.bold,
                color: Color(Colors.black45.value)),
          ))),
      new Divider(
        height: 2.0,
      ),
    ])));
  }
}
