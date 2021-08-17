import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'userSaleCardExample.dart';
import 'package:bread_delivery/Views/Products/ProductCard.dart';

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
        body: BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsError) snackBar(context, state.toString());
      },
      builder: (context, state) {
        if (state is ProductsLoaded) {
          return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                _getData();
              },
              child: Center(child: Text("Hola")));
        } else {
          return Center(
            child: Text("Cargar de nuevo"),
          );
        }
      },
    )

        // BlocListener<ProductsBloc, ProductsState>(
        //     listener: (context, state) => {
        //           if (state is ProductsError)
        //             snackBar(context, state.toString())
        //         },
        //     child: BlocBuilder<ProductsBloc, ProductsState>(
        //         builder: (context, state) {
        //       if (state is ProductsLoaded)
        //         return RefreshIndicator(
        //             key: _refreshIndicatorKey,
        //             onRefresh: () async {
        //               _getData();
        //             },
        //             child: Center(child: Text("Hola"))
        // ListView.builder(
        //     itemCount: state.products.length,
        //     padding: EdgeInsets.only(bottom: 55),
        //     //TODO Change the value of cacheExtent!!
        //     cacheExtent: 100000,
        //     addAutomaticKeepAlives: false,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Dismissible(
        //         key: ValueKey(state.products[index].id),
        //         direction: DismissDirection.startToEnd,
        //         onDismissed: (direction) {},
        //         background: Container(
        //           color: Colors.blue,
        //           padding: EdgeInsets.only(left: 16),
        //           child: Align(
        //             child: Icon(Icons.delete, color: Colors.white),
        //             alignment: Alignment.centerLeft,
        //           ),
        //         ),
        //         child: Container(),
        //       );
        //       // Card(
        //       //   child: ListTile(
        //       //     title: Text(state.products[index].name),
        //       //   ),
        //       // );
        //       // Row(
        //       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       //     children: [
        //       //       ProductCard(
        //       //           'Baguette', 'assets/images/baguette.png'),
        //       //       ProductCard(
        //       //           'Bolillo', 'assets/images/bolillo.png')
        //       //     ]);
        //       // Row(
        //       //     mainAxisAlignment:
        //       //         MainAxisAlignment.spaceEvenly,
        //       //     children: [
        //       //       ProductCard(
        //       //           'Cuerno', 'assets/images/cuerno.png'),
        //       //       ProductCard('Marihuano',
        //       //           'assets/images/marihuano.png')
        //       //     ]),
        //       // Row(
        //       //     mainAxisAlignment:
        //       //         MainAxisAlignment.spaceEvenly,
        //       //     children: [
        //       //       ProductCard('Pellizco',
        //       //           'assets/images/pellizco.png'),
        //       //       ProductCard('Baguette',
        //       //           'assets/images/baguette.png')
        //       //     ]),
        //       // Row(
        //       //     mainAxisAlignment:
        //       //         MainAxisAlignment.spaceEvenly,
        //       //     children: [
        //       //       ProductCard(
        //       //           'Bolillo', 'assets/images/bolillo.png'),
        //       //       ProductCard(
        //       //           'Cuerno', 'assets/images/cuerno.png')
        //       //     ]),
        //       // Row(
        //       //     mainAxisAlignment:
        //       //         MainAxisAlignment.spaceEvenly,
        //       //     children: [
        //       //       ProductCard('Pellizco',
        //       //           'assets/images/pellizco.png'),
        //       //       ProductCard('Baguette',
        //       //           'assets/images/baguette.png')
        //       //     ]),
        //     })
        //         );
        //   return LoadingScreen();
        // }))
        );
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }
}
