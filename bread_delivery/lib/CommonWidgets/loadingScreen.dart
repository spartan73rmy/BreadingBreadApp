import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatelessWidget {
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
                    "Horneando los panes...",
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
