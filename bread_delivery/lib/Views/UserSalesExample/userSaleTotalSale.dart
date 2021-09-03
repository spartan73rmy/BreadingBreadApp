import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleCardTotal.dart';

class TotalSale extends StatefulWidget {
  @override
  _TotalSale createState() => _TotalSale();
}

class _TotalSale extends State<TotalSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: ListView(
            children: [
              ProductCardTotal(),
            ],
          ),
        ),
        bottomSheet: BottomSheetTotal());
  }
}

class BottomSheetTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
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
                "Total: \$1,550",
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF1E9431))),
                onPressed: () {},
              ),
            )
          ],
        ),
      ));
}
