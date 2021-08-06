import 'package:flutter/material.dart';
import 'package:bread_delivery/Views/UserSales/userSaleCardExample.dart';

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(bottom: 55),
        cacheExtent: 100000,
        addAutomaticKeepAlives: false,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ProductCard('Baguette', 'assets/images/baguette.png'),
            ProductCard('Bolillo', 'assets/images/bolillo.png')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ProductCard('Cuerno', 'assets/images/cuerno.png'),
            ProductCard('Marihuano', 'assets/images/marihuano.png')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ProductCard('Pellizco', 'assets/images/pellizco.png'),
            ProductCard('Baguette', 'assets/images/baguette.png')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ProductCard('Bolillo', 'assets/images/bolillo.png'),
            ProductCard('Cuerno', 'assets/images/cuerno.png')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ProductCard('Pellizco', 'assets/images/pellizco.png'),
            ProductCard('Baguette', 'assets/images/baguette.png')
          ]),
        ]);
  }
}
