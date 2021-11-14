import 'package:bread_delivery/BLOC/Sale/bloc/sale_bloc.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Services/Sale/SaleRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'userSalePage.dart';

class SaleRootPage extends StatefulWidget {
  final UserSaleViewParams currentSale;

  const SaleRootPage(this.currentSale, {Key key}) : super(key: key);
  @override
  _SaleRootPageState createState() => _SaleRootPageState();
}

class _SaleRootPageState extends State<SaleRootPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SaleBloc(SaleRepository()),
        child: SalePage(widget.currentSale));
  }
}
