import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) functionPath;

  const BottomNavBar({Key key, this.functionPath}) : super(key: key);
  _bottomNavBar createState() => _bottomNavBar();
}

// ignore: camel_case_types
class _bottomNavBar extends State<BottomNavBar> {
  int numberPage = 0;

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
        backgroundColor: Color(0XFF785841),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: numberPage,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/bread.png'),
                size: 25,
              ),
              label: "Panes"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/exchange.png'),
                size: 25,
              ),
              label: "Devolución"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/bill.png'),
                size: 25,
              ),
              label: "Venta")
        ],
      ),
    );
  }
}
