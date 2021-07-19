import 'package:bread_delivery/BLOC/Promotions/bloc/promotions_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'promotionCard.dart';

class PromotionList extends StatefulWidget {
  final bool isAdmin;
  PromotionList(this.isAdmin);

  @override
  _PromotionListState createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  Future<List<Promotions>> data;
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
              if (state is PromotionsLoaded)
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: ListView.builder(
                        itemCount: state.Promotions.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: ValueKey(state.Promotions[index].idPromo),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {},
                              confirmDismiss: (direction) async {
                                final result = await showDialog(
                                        context: context,
                                        builder: (_) => DeleteDialog()) ??
                                    false;
                                if (result) {
                                  _deletePromotion(
                                      state.Promotions[index].idPromo);
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
                                  state.Promotions[index], isAdmin));
                        }));
              return LoadingScreen();
            })),
        floatingActionButton: isAdmin
            ? FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  //Todo: Add dialog to create promo
                },
                label: Text("Promocion"))
            : Container());
  }

  _addPromotion(int idProducto, int cantitySaleMin, int saleMin,
      int cantityFree, int discount) async {
    BlocProvider.of<PromotionsBloc>(context).add(
        AddPromotion(idProducto, cantityFree, saleMin, cantityFree, discount));
    BlocProvider.of<PromotionsBloc>(context).add(GetPromotions());
  }

  _deletePromotion(int id) async {
    BlocProvider.of<PromotionsBloc>(context).add(DeletePromotion(id));
    BlocProvider.of<PromotionsBloc>(context).add(GetPromotions());
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<PromotionsBloc>(context).add(GetPromotions());
  }
}
