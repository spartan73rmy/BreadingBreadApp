

import 'package:bread_delivery/Entities/InventoryViewParams.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Enums/Routes.dart';
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
    return GestureDetector(
      child: Card(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 75,
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              //VENDOR NAME
              Container(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  'Vendedor: ${data.vendorName}',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){ 
        Navigator.pushNamed(context, Routes.Inventory,
          arguments: InventoryViewParams(isAdmin, data)); 
      },
    );
  }
}