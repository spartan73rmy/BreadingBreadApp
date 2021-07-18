import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'ProductCard.dart';

class ProductList extends StatefulWidget {
  final bool isAdmin;
  ProductList(this.isAdmin);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<Products>> data;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool isAdmin;

  _isAdmin() {
    if (isAdmin == null) {
      setState(() {
        isAdmin = widget.isAdmin;
      });
    }
  }

  @override
  void initState() {
    _isAdmin();
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Productos"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.inventory),
            onPressed: () {},
          )
        ]),
        body: BlocListener<ProductsBloc, ProductsState>(
            listener: (context, state) =>
                {if (state is ProductsError) snackBar(context, state.toString())},
            child:
                BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
              if (state is ProductsLoaded)
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: ListView.builder(
                        itemCount: state.products.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: ValueKey(state.products[index].id),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {},
                              confirmDismiss: (direction) async {
                                final result = await showDialog(
                                        context: context,
                                        builder: (_) => DeleteDialog()) ??
                                    false;
                                if (result) {
                                  _deleteProduct(state.products[index].id);
                                }
                                return result;
                              },
                              background: Container(
                                color: Colors.blue,
                                padding: EdgeInsets.only(left: 16),
                                child: Align(
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              child: ProductCard(state.products[index], isAdmin));
                        }));
              return LoadingScreen();
            })),
        floatingActionButton: isAdmin
            ? FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  String nameValue;
                  double priceValue;
                  alertInputDiag(context, "Agregar Producto", "Nombre del producto",
                          "", "Nombre para el producto",
                          keyboard: TextInputType.text)
                      .then((value) {
                        if (value == null) return;
                        else nameValue = value;

                        alertInputDiag(context, "Agregar Producto", "Precio del producto",
                                "", "Precio para el producto",
                                keyboard: TextInputType.number)
                            .then((value) {
                              if (value == null) return;
                              else priceValue = double.parse(value);
                              // print(nameValue);
                              // print(priceValue);
                              if(nameValue != null && priceValue != null)
                                _addProduct(nameValue, priceValue);
                        });
                  });
                },
                label: Text("Producto"))
            : Container());
  }

  _addProduct(String name, double price) async {
    BlocProvider.of<ProductsBloc>(context).add(AddProduct(name, price));
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }

  _deleteProduct(int id) async {
    BlocProvider.of<ProductsBloc>(context).add(DeleteProduct(id));
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }
}
