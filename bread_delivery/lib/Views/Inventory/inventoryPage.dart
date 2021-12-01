import 'package:bread_delivery/BLOC/Inventory/bloc/inventory_bloc.dart';
import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Services/Inventory/inventoryRepository.dart';
import 'package:bread_delivery/Services/Printer/printerService.dart';
import 'package:bread_delivery/Services/Product/productRepository.dart';
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
        create: (_) =>
            InventoryBloc(InventoryRepository(), PrinterServiceImpl()),
        child: InventoryList(widget.isAdmin, widget._activePath));
  }
}
