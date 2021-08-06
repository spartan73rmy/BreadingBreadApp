import 'package:flutter/material.dart';
import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:bread_delivery/Views/UserSales/userSaleBottomNavBar.dart';
import 'package:bread_delivery/Views/UserSales/userSaleListProducts.dart';
import 'package:bread_delivery/Views/UserSales/userSaleReturnProduct.dart';
import 'package:bread_delivery/Views/UserSales/userSaleTotalSale.dart';

class LoginPage extends StatefulWidget {
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  int indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              title: Column(children: [
                Text(
                  "Ruta 1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Tienda San Nicolas",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )
              ]),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color(0XFF714012), Color(0XFFC26410)])),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: _setSectionBody(indexScreen)),
        Stack(children: <Widget>[
          new Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 55,
                  color: Colors.brown.withOpacity(.7),
                  child: BottomNavBar(
                    functionPath: (value) => {_returnValue(value)},
                  )),
            ),
          ),
        ])
      ],
    );
  }

  _returnValue(value) {
    setState(() {
      indexScreen = value;
    });
    _setSectionBody(indexScreen);
  }

  _setSectionBody(value) {
    switch (value) {
      case 0:
        return ListViewProducts();
      case 1:
        return ReturnProduct();
      case 2:
        return TotalSale();
    }
  }
}
