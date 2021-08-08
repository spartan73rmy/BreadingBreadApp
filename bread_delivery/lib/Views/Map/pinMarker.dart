import 'package:flutter/material.dart';

class PinMarker extends StatelessWidget {
  final String name;
  PinMarker(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [FlutterLogo()]),
    );
  }
}
