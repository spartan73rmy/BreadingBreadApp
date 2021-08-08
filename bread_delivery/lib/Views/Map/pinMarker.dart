import 'package:flutter/material.dart';

class PinMarker extends StatelessWidget {
  final String name;
  PinMarker(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(
        Icons.store,
        color: Color(Colors.indigoAccent.value),
      ),
      Text(
        this.name,
        style: TextStyle(fontSize: 12, color: Color(Colors.black.value)),
      )
    ]);
  }
}
