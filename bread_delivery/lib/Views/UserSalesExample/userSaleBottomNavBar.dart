import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) functionPath;

  const BottomNavBar({Key key, this.functionPath}) : super(key: key);
  _bottomNavBar createState() => _bottomNavBar();
}

// ignore: camel_case_types
class _bottomNavBar extends State<BottomNavBar> {
  int numberPage = 0;
  double imgSizeIcon = 25;
  Color colorBrown = Color(0XFF674023);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            numberPage = index;
            widget.functionPath(numberPage);
          });
        },
        backgroundColor: colorBrown,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: numberPage,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/bread.png'),
                size: imgSizeIcon,
              ),
              label: "Panes"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/bill.png'),
                size: imgSizeIcon,
              ),
              label: "Venta")
        ],
      ),
    );
  }
}
