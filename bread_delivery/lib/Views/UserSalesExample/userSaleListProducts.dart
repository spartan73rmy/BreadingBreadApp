import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'userSaleCard.dart';

class ListViewProducts extends StatefulWidget {
  @override
  _ListViewProducts createState() => _ListViewProducts();
}

class _ListViewProducts extends State<ListViewProducts> {
  Future<List<Products>> data;
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
            if (state is ProductsLoaded) {
              return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    _getData();
                  },
                  child: ListView.builder(
                      itemCount: state.products.length,
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
                              ProductCard(data: state.products[index])
                            ]));
                      }));
            } else {
              return MessageScreen.message("No hay datos");
            }
          },
        ));
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }
}
