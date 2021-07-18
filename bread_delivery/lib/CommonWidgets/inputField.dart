import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType input;
  final String error;
  final String placeHolder;
  InputField(this.placeHolder, this.textController, this.error, this.input);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), //color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 5, // blur radius
                        offset: Offset(0, 5),
                      )
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: placeHolder,
                    hintStyle: TextStyle(color: Colors.brown, fontSize: 20),
                    errorText: error,
                  ),
                  style: TextStyle(color: Colors.brown, fontSize: 20),
                  cursorColor: Colors.brown,
                  keyboardType: input,
                  controller: textController,
                ))
          ],
        ));
  }
}
