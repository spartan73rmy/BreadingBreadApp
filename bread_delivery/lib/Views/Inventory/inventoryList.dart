import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/activePath.dart';
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
  void initState(){
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._activePath.name)),
      body: BlocListener<ProductsBloc,ProductsState>(
        listener: (context,state) => {
          if(state is ProductsError) snackBar(context, state.toString())
        },
        child: BlocBuilder<ProductsBloc,ProductsState>(
          builder: (context,state) {
            if(state is ProductsLoaded)
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                _getData();
              },
              child: Column(
                children:[

                  //LISTA
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          child: inventoryCard(state.products[index])
                        );
                      },
                    ),
                  ),

                  //BOTTOM BUTTON
                  Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: ElevatedButton(
                      child: Text(
                        'Guardar inventario',
                        style: styleTextButton,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.brown),
                      ),
                      onPressed: () {
                        //no se me ocurre como acceder a los datos de la lista :V
                        //TODO: ADD FUNCITON TO PRINT TICKET
                      }, 
                    )
                  )
                ]
              ) 
            );
            return MessageScreen();
          },
        ),
      ),
      
    );
  }
  

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }

  //TODO: CREATE FUNCTION TO PRINT TICKET
}