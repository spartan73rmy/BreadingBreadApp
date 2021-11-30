

import 'package:bread_delivery/Entities/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class inventoryCard extends StatefulWidget {
  final Product data;
  inventoryCard(this.data, {Key key}) : super(key: key);

  @override
  _inventoryCardState createState() => _inventoryCardState();
}

class _inventoryCardState extends State<inventoryCard> {

  var _quantity = TextEditingController.fromValue(TextEditingValue(text: '0'));

  TextStyle styleTextNameProduct = GoogleFonts.lora(
      color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold);
  TextStyle styleTextNormal = GoogleFonts.lora(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal);
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0XFF674023),Color(0XFF9E5F32)]
          )
        ),
        child: Row(
          children: [
            
            //PRODUCT IMAGE
            Container(
              width: 75,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                image:DecorationImage(
                  image: AssetImage('assets/images/cuerno.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),

            //PRODUCT NAME
            Container(
              width: MediaQuery.of(context).size.width - 75,
              child: Text(
                  widget.data.name,
                  style: styleTextNameProduct,
                ),
            ),

            //QUANTITY DISPLAY
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Cantidad',
                  style: styleTextNormal,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(.5),
                    border: Border.all(width: 1, color: Colors.white)
                  ),

                  child: TextField(
                    controller: _quantity,
                    keyboardType: TextInputType.number,
                    style: styleTextNormal,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}