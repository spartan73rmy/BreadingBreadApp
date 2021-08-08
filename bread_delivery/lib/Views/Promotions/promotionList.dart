import 'package:bread_delivery/BLOC/Promotions/bloc/promotions_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alert.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'promotionCard.dart';

class PromotionList extends StatefulWidget {
  final bool isAdmin;
  final Product _product;
  PromotionList(this.isAdmin, this._product);

  @override
  _PromotionListState createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  List<Promotions> data;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getData(widget._product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Promociones"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alt_route_rounded),
            onPressed: () {},
          )
        ]),
        body: BlocListener<PromotionsBloc, PromotionsState>(
            listener: (context, state) => {
                  if (state is PromotionsError)
                    snackBar(context, state.toString())
                },
            child: BlocBuilder<PromotionsBloc, PromotionsState>(
                builder: (context, state) {
              if (state is PromotionsLoaded) {
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData(widget._product);
                    },
                    child: ListView.builder(
                        itemCount: state.promotions.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: ValueKey(state.promotions[index].idPromo),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {},
                              confirmDismiss: (direction) async {
                                final result = await showDialog(
                                        context: context,
                                        builder: (_) => DeleteDialog()) ??
                                    false;
                                if (result) {
                                  _deletePromotion(
                                      state.promotions[index].idPromo);
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
                              child: PromotionCard(
                                  state.promotions[index], widget.isAdmin));
                        }));
              }
              return LoadingScreen();
            })),
        floatingActionButton: widget.isAdmin
            ? FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  await showDialogWithFields(context);
                },
                label: Text("Promocion"))
            : Container());
  }

  _addPromotion(int idProducto, int cantitySaleMin, int saleMin,
      int cantityFree, int discount) async {
    BlocProvider.of<PromotionsBloc>(context).add(
        AddPromotion(idProducto, cantityFree, saleMin, cantityFree, discount));
    BlocProvider.of<PromotionsBloc>(context)
        .add(GetPromotionsByProduct(widget._product.id));
  }

  _deletePromotion(int id) async {
    BlocProvider.of<PromotionsBloc>(context).add(DeletePromotion(id));
    BlocProvider.of<PromotionsBloc>(context)
        .add(GetPromotionsByProduct(widget._product.id));
  }

  _getData(Product product) async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<PromotionsBloc>(context)
        .add(GetPromotionsByProduct(product.id));
  }

  Future<void> showDialogWithFields(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          // ignore: non_constant_identifier_names
          var DiscountController = TextEditingController();
          // ignore: non_constant_identifier_names
          var TypeController = TextEditingController();
          bool isDiscount = false;
          bool isPerQuantity = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Nueva Promocion'),
              content: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Venta"),
                          Switch(
                              value: isPerQuantity,
                              onChanged: (value) {
                                setState(() {
                                  isPerQuantity = value;
                                });
                              }),
                          Text("Cantidad")
                        ],
                      ),
                      TextFormField(
                        controller: TypeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: isPerQuantity
                              ? "Venta minima (Cantidad)"
                              : "Venta minima (\$)",
                          icon: isPerQuantity
                              ? Icon(Icons.production_quantity_limits)
                              : Icon(Icons.attach_money),
                        ),
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "El campo no puede estar vacio";
                        },
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gratis"),
                          Switch(
                              value: isDiscount,
                              onChanged: (value) {
                                setState(() {
                                  isDiscount = value;
                                });
                              }),
                          Text("Descuento")
                        ],
                      ),
                      TextFormField(
                        controller: DiscountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: isDiscount
                                ? "Descuento (%)"
                                : "Producto Gratis",
                            icon: isDiscount
                                ? Icon(Icons.new_releases)
                                : Icon(Icons.add_shopping_cart)),
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
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      var Type = TypeController.text;
                      var Discount = DiscountController.text;
                      int idProducto = 0;
                      int cantitySaleMin =
                          (isPerQuantity) ? int.parse(Type) : 0;
                      int saleMin = (!isPerQuantity) ? int.parse(Type) : 0;
                      int cantityFree = (!isDiscount) ? int.parse(Discount) : 0;
                      int discount = (isDiscount) ? int.parse(Discount) : 0;
                      await _addPromotion(idProducto, cantitySaleMin, saleMin,
                          cantityFree, discount);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Agregar'),
                ),
              ],
            );
          });
        });
  }
}
