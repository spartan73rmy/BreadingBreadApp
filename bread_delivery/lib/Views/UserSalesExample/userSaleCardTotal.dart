import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class userSaleCardTotal extends StatelessWidget {
  const userSaleCardTotal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            // PRIMARY CONTAINER
            Container(
                width: 330,
                height: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2))
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color(0XFF714012), Color(0XFFC26410)])),
                child: Row(
                  children: [
                    // IMAGE
                    Container(
                      width: 105,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images/cuerno.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),

                    // PRODUCT NAME
                    Container(
                      width: 225,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Cuernito",
                              style: GoogleFonts.lora(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Column(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.center,
                                    children: [
                                      // PRODUCT LABEL
                                      Container(
                                        child: Text(
                                          "Precio",
                                          style: GoogleFonts.lora(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // PRODUCT PRICE
                                      Container(
                                        child: Text(
                                          r"$6.5",
                                          style: GoogleFonts.lora(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      // LABEL QUANTITY
                                      Container(
                                        child: Text(
                                          "Cantidad",
                                          style: GoogleFonts.lora(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // AMOUNT
                                      Container(
                                        child: Text("20",
                                            style: GoogleFonts.lora(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      // LABEL SALE
                                      Container(
                                        child: Text("Total",
                                            style: GoogleFonts.lora(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      // TOTAL PRICE
                                      Container(
                                        child: Text(r"$130",
                                            style: GoogleFonts.lora(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
