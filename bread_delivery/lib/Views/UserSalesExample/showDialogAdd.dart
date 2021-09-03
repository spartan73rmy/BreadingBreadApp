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
  var getResultInputText = {0: "", 1: ""};
  bool checkBoxValue = false;
  final ButtonStyle styleAdd = ElevatedButton.styleFrom(
      primary: Color(0XFF378C36), textStyle: const TextStyle(fontSize: 20));
  final ButtonStyle styleDelete = ElevatedButton.styleFrom(
      primary: Color(0XFF8B0000), textStyle: const TextStyle(fontSize: 20));
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
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
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: this.widget.textFieldControllerSale,
                  decoration: InputDecoration(hintText: "Cantidad"),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Text(
                        "¿Devoluciones?",
                        style: TextStyle(fontSize: 18),
                      ),
                      Checkbox(
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
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: this.widget.textFieldControllerReturn,
                          decoration: InputDecoration(hintText: "Devolucion"),
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
                          Navigator.pop(context, "");
                        },
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text('Ok'),
                        style: styleAdd,
                        onPressed: () {
                          getResultInputText[0] =
                              this.widget.textFieldControllerSale.text;
                          getResultInputText[1] =
                              this.widget.textFieldControllerReturn.text;
                          Navigator.pop(context, getResultInputText);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
