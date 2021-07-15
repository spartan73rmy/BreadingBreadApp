import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/Services/Product/productRepository.dart';
import 'package:bread_delivery/Views/Products/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const ProductsPage(this.title, this.isAdmin, {Key key}) : super(key: key);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProductsBloc(ProductRepository()),
        child: ProductList(widget.isAdmin));
  }
}
