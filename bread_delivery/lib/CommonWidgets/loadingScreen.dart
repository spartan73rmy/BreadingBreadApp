import 'package:bread_delivery/CommonWidgets/buttonPrimary.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 150.0),
        child: new Center(
            child: new Column(
          children: <Widget>[
            CircularProgressIndicator(strokeWidth: 4.0),
            new Container(
              padding: const EdgeInsets.all(12.0),
              child: new Text(
                'Espere',
                style: new TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        )));
  }
}
