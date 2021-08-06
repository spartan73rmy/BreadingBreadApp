import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  TextEditingController textController;
  TextInputType input;
  String error;
  String placeHolder;

  InputField(this.placeHolder, this.textController, this.error, this.input);

  InputField.onlyName(this.placeHolder);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), //color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 5, // blur radius
                        offset: Offset(0, 1),
                      )
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      border: InputBorder.none,
                      hintText: placeHolder,
                      hintStyle: TextStyle(color: Colors.brown, fontSize: 20),
                      errorText: error),
                  style: TextStyle(color: Colors.brown, fontSize: 20),
                  cursorColor: Colors.brown,
                  keyboardType: input,
                  controller: textController,
                )),
          ],
        ));
  }
}
