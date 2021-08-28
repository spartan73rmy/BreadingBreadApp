import 'package:flutter/material.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleCardTotal.dart';

class TotalSale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          userSaleCardTotal(),
        ],
      ),
    );
  }
}
