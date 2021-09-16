import 'package:bread_delivery/Services/UserSale/userSaleDatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardTotal extends StatelessWidget {
  PriorSale data;
  ProductCardTotal(this.data);

  _getTotalSaleProduct() {
    int total = int.parse(data.saleQuantity) - int.parse(data.refundAmount);
    double totalSale =
        double.parse(total.toString()) * double.parse(data.priceProduct);
    return totalSale.toString();
  }

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
                  colors: <Color>[Color(0XFF674023), Color(0XFF9E5F32)])),
          child: Row(
            children: [
              //IMAGE
              Container(
                width: 75,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/cuerno.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              //INFORMATION
              Container(
                width: MediaQuery.of(context).size.width - 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //NAME PRODUCT
                    Container(
                      child: Text(
                        data.nameProduct,
                        style: GoogleFonts.lora(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //INVENTORY
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Text(
                              "Precio\n \$" + data.priceProduct,
                              style: GoogleFonts.lora(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              child: Text(
                            "Cantidad: " +
                                data.saleQuantity +
                                "\nDevolucion: " +
                                data.refundAmount,
                            style: GoogleFonts.lora(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(.5),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Text("Total\n\$" + _getTotalSaleProduct(),
                                style: GoogleFonts.lora(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
