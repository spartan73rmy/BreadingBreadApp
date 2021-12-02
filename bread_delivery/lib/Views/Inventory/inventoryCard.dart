import 'package:bread_delivery/Entities/productInventory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryCard extends StatefulWidget {
  final ProductInventory data;
  InventoryCard(this.data, {Key key}) : super(key: key);

  @override
  _InventoryCardState createState() => _InventoryCardState();
}

class _InventoryCardState extends State<InventoryCard> {
  var _quantity = TextEditingController.fromValue(TextEditingValue(text: '0'));

  TextStyle styleTextNameProduct = GoogleFonts.lora(
      color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold);
  TextStyle styleTextNormal = GoogleFonts.lora(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal);
  TextStyle styleTextQuantity = GoogleFonts.lora(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0XFF674023), Color(0XFF9E5F32)])),
        child: Row(
          children: [
            //PRODUCT IMAGE ??

            //PRODUCT NAME
            Container(
                padding: EdgeInsets.only(left: 10),
                width: (MediaQuery.of(context).size.width * 2) / 3,
                child: Text(
                  widget.data.name,
                  style: styleTextNameProduct,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )),

            // QUANTITY
            Container(
                width: ((MediaQuery.of(context).size.width) / 3) - 10,
                height: (MediaQuery.of(context).size.height),
                padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Cantidad:",
                        style: styleTextNormal,
                      ),
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _quantity,
                      onTap: () => _quantity.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _quantity.value.text.length),
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      style: styleTextQuantity,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white30),
                              borderRadius: BorderRadius.circular(10.0)),
                          filled: true,
                          fillColor: Color(0XFF674023)),
                      onChanged: (text) {
                        widget.data.quantity = int.tryParse(text);
                      },
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
