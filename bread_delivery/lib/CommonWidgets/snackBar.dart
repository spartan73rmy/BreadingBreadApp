import 'package:flutter/material.dart';

void snackBar(BuildContext context, String value) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(value)));
}
