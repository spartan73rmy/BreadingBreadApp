import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalSale extends StatefulWidget {
  UserSaleViewParams currentSale;
  TotalSale(this.currentSale, {Key key}) : super(key: key);
  @override
  _TotalSale createState() => _TotalSale();
}

class _TotalSale extends State<TotalSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(),
        bottomSheet: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0XFF674023), Color(0XFF9E5F32)])),
            width: MediaQuery.of(context).size.width,
            height: 110,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Total: \$ ${widget.currentSale.products.fold(0, (value, element) => value + element ?? 0)}',
                      style: GoogleFonts.lora(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text("Cobrar",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF1E9431))),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )));
  }
}
