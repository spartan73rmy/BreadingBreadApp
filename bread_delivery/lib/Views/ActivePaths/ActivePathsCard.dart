

import 'package:bread_delivery/Entities/activePath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivePathCard extends StatefulWidget {
  final ActivePath data;
  final bool isAdmin;
  ActivePathCard(this.data, this.isAdmin, {Key key}) : super(key: key);
  @override
  _ActivePathState createState() => _ActivePathState(this.data, this.isAdmin);
}

class _ActivePathState extends State<ActivePathCard> {
  final ActivePath data;
  final bool isAdmin;
  _ActivePathState(this.data, this.isAdmin);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0XFF674023),Color(0XFF9E5F32)]
          )
        ),
        child: Column(
          children: [
            //ROUTE NAME
            Container(
              child: Text(
                data.name,
                style: GoogleFonts.lora(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            //VENDOR NAME
            Container(
              child: Text(
                'Vendedor: ${data.id}',
                style: GoogleFonts.lora(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}