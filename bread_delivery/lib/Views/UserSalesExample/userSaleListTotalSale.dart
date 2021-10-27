import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleCardTotal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalSale extends StatefulWidget {
  final UserSaleViewParams currentSale;
  TotalSale(this.currentSale, {Key key}) : super(key: key);
  @override
  _TotalSale createState() => _TotalSale();
}

class _TotalSale extends State<TotalSale> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentSale.products.isEmpty) Container();
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
            itemCount: widget.currentSale.products.length,
            padding: EdgeInsets.only(bottom: 60),
            //TODO Change the value of cacheExtent!!
            cacheExtent: 100000,
            addAutomaticKeepAlives: true,
            itemBuilder: (BuildContext context, int index) {
              if (widget.currentSale.products[index].inSale())
                return Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      ProductCardTotal(widget.currentSale.products[index])
                    ]));
              return Container();
            }));
  }
}
