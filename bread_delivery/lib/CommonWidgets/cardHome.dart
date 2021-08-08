import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final String pathIcon;
  final String nameTitle;
  final VoidCallback onPressCallBack;

  CardHome(this.pathIcon, this.nameTitle, this.onPressCallBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressCallBack,
        child: Column(children: [
          Container(
            width: 75,
            height: 75,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3), //color of shadow
                      spreadRadius: 1, //spread radius
                      blurRadius: 5, // blur radius
                      offset: Offset(0, 3))
                ],
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0XFF714012), Color(0XFFC26410)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageIcon(
                  AssetImage(pathIcon),
                  size: 40,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Container(
              child: Text(
            nameTitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ))
        ]));
  }
}
