import 'package:bread_delivery/Views/Products/productCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'showDialogAdd.dart';

class ProductCard extends StatefulWidget {
  final Product data;

  ProductCard({this.data});

  _ProductCard createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  var resultsvaluesTextInput = {0: "0", 1: "0"};

  void _isNumberInt(Map valuesTextInput) {
    int amount;
    for (var i = 0; i < valuesTextInput.length; i++) {
      try {
        amount = int.tryParse(valuesTextInput[i]);
      } catch (e) {
        resultsvaluesTextInput[i] = "0";
      }
      if (amount >= 0 && amount <= 999)
        resultsvaluesTextInput[i] = amount.toString();
    }
  }

  void _saveResultValueWithIndexProduct() {}

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
                        this.widget.data.name,
                        style: GoogleFonts.lora(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //INVENTORY
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //BOX INVENTORY
                          Container(
                            width: 180,
                            height: 60,
                            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.4),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Text(
                                    "Inv: 0",
                                    style: GoogleFonts.lora(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Venta: " +
                                              resultsvaluesTextInput[0]
                                                  .toString(),
                                          style: GoogleFonts.lora(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Dev: " +
                                              resultsvaluesTextInput[1]
                                                  .toString(),
                                          style: GoogleFonts.lora(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //BOX BUTTON
                          Container(
                            child: ElevatedButton(
                              child: Text("Agregar",
                                  style: TextStyle(color: Colors.white)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF1E9431))),
                              onPressed: () async {
                                resultsvaluesTextInput =
                                    await _displayTextInputDialog(context);
                                setState(() {
                                  _isNumberInt(resultsvaluesTextInput);
                                });
                              },
                            ),
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

  Future<Map> _displayTextInputDialog(BuildContext context) async {
    TextEditingController _textFieldControllerSale = TextEditingController();
    TextEditingController _textFieldControllerReturn = TextEditingController();
    try {
      return await showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            textFieldControllerSale: _textFieldControllerSale,
            textFieldControllerReturn: _textFieldControllerReturn,
          );
        },
      );
    } catch (e) {
      return null;
    }
  }
}
