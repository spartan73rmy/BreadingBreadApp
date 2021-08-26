import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bread_delivery/Entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product data;

  ProductCard(this.data);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: 170,
          height: 250,
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
          child: Column(children: [
            Container(
                width: 200,
                height: 50,
                child: Container(
                  child: Center(
                      child: Text(
                    '${data.name}',
                    style: GoogleFonts.lora(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                )),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(''),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Center(child: productAmount())
          ])),
    );
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
  void _changeValue(value) {
    setState(() {
      if (value == "plus" && counter < 99)
        counter++;
      else if (value == "minus" && counter > 0) counter--;
    });
    print(counter);
  }

  _isNumberInt(value) {
    try {
      int amount = int.parse(value);
      print(amount);
      if (amount >= 0 && amount <= 99) counter = amount;
    } catch (e) {
      counter = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
            child: IconButton(
          icon: Icon(FontAwesomeIcons.minus),
          iconSize: 25,
          color: Colors.white,
          onPressed: () {
            _changeValue("minus");
          },
        )),
        InkWell(
            onTap: () async {
              String value = await _displayTextInputDialog(context);
              setState(() {
                _isNumberInt(value);
              });
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: Colors.white.withOpacity(.5)),
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(
                counter.toString(),
                style: GoogleFonts.lora(fontSize: 20, color: Colors.white),
              )),
            )),
        Container(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.plus),
            iconSize: 25,
            color: Colors.white,
            onPressed: () {
              _changeValue("plus");
            },
          ),
        )
      ]),
    );
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
