import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatelessWidget {
  String showMessage = "Horneando los panes...";
  MessageScreen();
  MessageScreen.message(this.showMessage) {
    this.showMessage = showMessage;
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0XFF674023),
      child: Container(
        height: 110,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/baker.png')),
                )),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 250,
                height: 30,
                child: Center(
                  child: Text(
                    showMessage,
                    style: GoogleFonts.lora(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
