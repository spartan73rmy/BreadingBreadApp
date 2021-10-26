import 'package:bread_delivery/Entities/productSale.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardTotal extends StatelessWidget {
  ProductSale data;
  ProductCardTotal(this.data);

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
                        data.name,
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
                              'Precio\n \$ ${data.prize}',
                              style: GoogleFonts.lora(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              child: Text(
                            'Cantidad: ${data.cantity}' +
                                '\nDevolucion: ${data.returns}',
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
                            child: Text('Total\n\$ ${data.total()}',
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
