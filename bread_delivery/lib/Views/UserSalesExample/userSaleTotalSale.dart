import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleCardTotal.dart';
import 'package:bread_delivery/Services/UserSale/userSaleDatabase.dart';

class TotalSale extends StatefulWidget {
  @override
  _TotalSale createState() => _TotalSale();
}

class _TotalSale extends State<TotalSale> {
  SalePreviewDatabase db = SalePreviewDatabase();
  SalePreview mapsIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: db.init(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FutureBuilder(
                  future: db.salePreview(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SalePreview>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: [
                          for (mapsIndex in snapshot.data.map((e) => e))
                            ProductCardTotal(mapsIndex)
                        ],
                      );
                    } else {
                      return Text("No hay datos");
                    }
                  },
                );
              } else {
                return Text("");
              }
            }),
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
