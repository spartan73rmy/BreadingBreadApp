import 'package:bread_delivery/BLOC/Inventory/bloc/inventory_bloc.dart';
import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Views/Inventory/inventoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryList extends StatefulWidget {
  final ActivePath _activePath;
  final bool isAdmin;
  InventoryList(this.isAdmin, this._activePath, {Key key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TextStyle styleTextButton = GoogleFonts.lora(
      color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack( 
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text(widget._activePath.name)),
          body: BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) =>
                {if (state is InventoryError) snackBar(context, state.toString())},
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                if (state is ProductsLoaded)
                  return RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        _getData();
                      },
                      child: Column(children: [
                        //LISTA
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.products.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: inventoryCard(state.products[index]));
                            },
                          ),
                        ),

                        //BOTTOM BUTTON
                        Container(
                          width: 500,
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.local_shipping,size: 35,),
                            label: Text("Guardar",style: styleTextButton,),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0XFF674023)),
                              padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical: 15)),
                            ),
                            onPressed: () async {
                              //TODO: CHECK PERMISSION BLUETOOTH
                              //TODO:IMPLEMENT FUNCITON TO GET MAC PRINTER
                              String MAC = _getBluetoothDevices();

                              _saveInventory(
                                  state.products, widget._activePath, MAC);
                            },
                          ))
                      ]));
                return MessageScreen();
              },
            ),
          ),
        )
      ],
    );
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<InventoryBloc>(context).add(GetProducts());
  }

  String _getBluetoothDevices() {
    //Se necesita para cosultar y seleccionar la impresora para imprimir
    return "MAC";
  }

  _saveInventory(
      List<Product> products, ActivePath currentPath, String MAC) async {
    //TODO: CREATE FUNCTION TO PRINT TICKET

    BlocProvider.of<InventoryBloc>(context)
        .add(AddInventoryProducts(products, currentPath, MAC));
  }
}
