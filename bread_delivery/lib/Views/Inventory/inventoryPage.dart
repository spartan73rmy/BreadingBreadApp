

import 'package:bread_delivery/BLOC/UserSale/bloc/usersales_bloc.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Services/UserSale/userSaleRespository.dart';
import 'package:bread_delivery/Views/Inventory/inventoryList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryPage extends StatefulWidget {
  final ActivePath _activePath;
  final bool isAdmin;
  InventoryPage(this._activePath, this.isAdmin, {Key key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>UserSalesBloc(UserSalesRepository()),
      child: InventoryList(widget.isAdmin, widget._activePath)
    );
  }
}