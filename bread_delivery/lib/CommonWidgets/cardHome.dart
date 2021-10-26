import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final String pathIcon;
  final String nameTitle;
  final VoidCallback onPressCallBack;
  
  MediaQueryData _mqd;
  double totalWidth;
  // double totalheight;
  double cardBoxSize;
  double cardMarginVSize;
  double cardMarginHSize;

  CardHome(this.pathIcon, this.nameTitle, this.onPressCallBack);
  @override
  Widget build(BuildContext context) {
    _mqd = MediaQuery.of(context);
    totalWidth = _mqd.size.width;
    // totalheight = _mqd.size.height;
    cardBoxSize = totalWidth / 4;
    cardMarginVSize = totalWidth / 36;
    cardMarginHSize = totalWidth / 18;

    // print(totalWidth);
    // print(cardMarginVSize);
    // print(cardMarginHSize);
    // print(cardBoxSize);

    return GestureDetector(
        onTap: onPressCallBack,
        child: Column(children: [
          Container(
            width: cardBoxSize,
            height: cardBoxSize,
            // margin: EdgeInsets.all(cardMarginSize), //prev 10
            margin: EdgeInsets.symmetric(vertical: cardMarginVSize,horizontal:cardMarginHSize),
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
                    colors: <Color>[Color(0XFF674023), Color(0XFF9E5F32)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageIcon(
                  AssetImage(pathIcon),
                  size: (cardBoxSize >= 150)? 80 : 40,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Container(
              child: Text(
            nameTitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: (cardBoxSize >= 150)? 24:15 ),//prev 15
          ))
        ]));
  }
}
