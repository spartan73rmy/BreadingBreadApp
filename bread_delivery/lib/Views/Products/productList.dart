import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
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
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
            listener: (context, state) => {
                  if (state is ProductsError)
                    snackBar(context, state.toString())
                },
            child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
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
                              child:
                                  ProductCard(state.products[index], isAdmin));
                        }));
              return MessageScreen();
            })),
        floatingActionButton: isAdmin
            ? FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  showDialogWithFields(context);
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

  Future<void> showDialogWithFields(
    BuildContext context,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var NameController = TextEditingController();
          var PriceController = TextEditingController();

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Agregar Producto', textAlign: TextAlign.center,),
              content: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Nombre',
                        style: const TextStyle(fontWeight: FontWeight.bold,height: 1),),
                      TextFormField(
                        controller: NameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration( 
                          hintText: "Nombre",
                          icon: Icon(Icons.mode_edit), ),
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "El campo no puede estar vacio";
                        },
                      ),
                      Divider(),
                      Text(
                        'Precio',
                        style: const TextStyle(fontWeight: FontWeight.bold,height: 2),),
                      TextFormField(
                        controller: PriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Precio",
                            icon: Icon(Icons.attach_money)),
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "El campo no puede estar vacio";
                        },
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      var NewName = NameController.text;
                      var NewPrice = double.parse(PriceController.text);
                      _addProduct(NewName, NewPrice);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            );
          });
        });
  }
}
