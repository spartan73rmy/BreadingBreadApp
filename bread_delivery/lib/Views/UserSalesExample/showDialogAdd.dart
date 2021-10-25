import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final TextEditingController textFieldControllerSale;
  final TextEditingController textFieldControllerReturn;

  CustomAlertDialog(
      {this.textFieldControllerSale, this.textFieldControllerReturn});
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  double fontSize20 = 20;
  Color colorBrown = Color(0XFF674023);
  var resultInputText = {0: "0", 1: "0"};
  bool checkBoxValue = false;
  final ButtonStyle styleAdd = ElevatedButton.styleFrom(
      primary: Color(0XFF378C36), textStyle: const TextStyle(fontSize: 20));
  final ButtonStyle styleDelete = ElevatedButton.styleFrom(
      primary: Color(0XFF8B0000), textStyle: const TextStyle(fontSize: 20));
  final TextStyle textStyleHint =
      TextStyle(color: Color(0XFF674023), fontSize: 18);
  final TextStyle textStyleField =
      TextStyle(color: Color(0XFF674023), fontSize: 20);

  _getResultsInputText() {
    resultInputText[0] = this.widget.textFieldControllerSale.text;
    resultInputText[1] = this.widget.textFieldControllerReturn.text;
    _isNumeric(resultInputText);
  }

  _isNumeric(Map<int, String> valuesTextController) {
    for (var i = 0; i < valuesTextController.length; i++) {
      try {
        num value = num.tryParse(valuesTextController[i]);
        if (value <= 0 || value > 999) valuesTextController[i] = "0";
      } catch (e) {
        valuesTextController[i] = "0";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _getResultsInputText();
          Navigator.pop(context, resultInputText);
          return true;
        },
        child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Ingrese cantidad",
                      style: TextStyle(fontSize: fontSize20),
                    ),
                  ),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: this.widget.textFieldControllerSale,
                      style: textStyleField,
                      decoration: InputDecoration(
                          hintText: "Cantidad", hintStyle: textStyleHint),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            "¿Devoluciones?",
                            style: TextStyle(fontSize: fontSize20),
                          ),
                          Checkbox(
                              activeColor: colorBrown,
                              value: checkBoxValue,
                              onChanged: (bool value) {
                                setState(() {
                                  checkBoxValue = value;
                                });
                              }),
                        ],
                      )),
                  Visibility(
                      visible: checkBoxValue,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Ingrese cantidad",
                              style: TextStyle(fontSize: fontSize20),
                            ),
                          ),
                          Container(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: this.widget.textFieldControllerReturn,
                              style: textStyleField,
                              decoration: InputDecoration(
                                  hintText: "Devolución",
                                  hintStyle: textStyleHint),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: ElevatedButton(
                            child: Text('Cancelar'),
                            style: styleDelete,
                            onPressed: () {
                              _getResultsInputText();
                              Navigator.pop(context, resultInputText);
                            },
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            child: Text('Ok'),
                            style: styleAdd,
                            onPressed: () {
                              _getResultsInputText();
                              Navigator.pop(context, resultInputText);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
