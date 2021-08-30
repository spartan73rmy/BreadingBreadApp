import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bread_delivery/Entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product data;

  ProductCard(this.data);
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
                                          "Venta: 0",
                                          style: GoogleFonts.lora(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Dev: 0",
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
                              onPressed: () {},
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
}

// ignore: camel_case_types
class productAmount extends StatefulWidget {
  const productAmount({Key key}) : super(key: key);

  _State createState() => _State();
}

class _State extends State<productAmount> {
  final snackError = SnackBar(content: const Text("Número no valido"));
  int counter = 0;

  void _isNumberInt(value) {
    try {
      int amount = int.parse(value);
      if (amount >= 0 && amount <= 99) counter = amount;
    } catch (e) {
      counter = 0;
    }
  }

  void _saveResultValueWithIndexProduct() {
    if (counter != 0) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<String> _displayTextInputDialog(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();
    final ButtonStyle styleAdd = ElevatedButton.styleFrom(
        primary: Color(0XFF378C36), textStyle: const TextStyle(fontSize: 20));
    final ButtonStyle styleDelete = ElevatedButton.styleFrom(
        primary: Color(0XFF8B0000), textStyle: const TextStyle(fontSize: 20));
    try {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingrese cantidad'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Cantidad"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Cancelar'),
                style: styleDelete,
                onPressed: () {
                  Navigator.pop(context, "");
                },
              ),
              ElevatedButton(
                child: Text('Ok'),
                style: styleAdd,
                onPressed: () {
                  Navigator.pop(context, _textFieldController.text);
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      return "";
    }
  }
}
