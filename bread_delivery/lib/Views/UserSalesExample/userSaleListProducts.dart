import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/productSale.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'userSaleCard.dart';

class ListViewProducts extends StatefulWidget {
  final UserSaleViewParams currentSale;
  ListViewProducts(this.currentSale, {Key key}) : super(key: key);

  @override
  _ListViewProducts createState() => _ListViewProducts();
}

class _ListViewProducts extends State<ListViewProducts> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsError) snackBar(context, state.toString());
          },
          builder: (context, state) {
            if (state is ProductsLoading) {
              return MessageScreen();
            }
            if (state is ProductsForSaleLoaded) {
              if (widget.currentSale.products?.isEmpty ?? true)
                widget.currentSale.products = state.products;

              return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    if (widget.currentSale.products?.isEmpty ?? true)
                      _getData();
                  },
                  child: ListView.builder(
                      itemCount: widget.currentSale.products.length,
                      padding: EdgeInsets.only(bottom: 60),
                      //TODO Change the value of cacheExtent!!
                      cacheExtent: 100000,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                              ProductCard(
                                  data: widget.currentSale.products[index])
                            ]));
                      }));
            }
            return Container();
          },
        ));
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    if (widget.currentSale.products?.isEmpty ?? true)
      BlocProvider.of<ProductsBloc>(context).add(GetProductForSale());
    else
      BlocProvider.of<ProductsBloc>(context)
          .emit(ProductsForSaleLoaded(<ProductSale>[]));
  }
}
