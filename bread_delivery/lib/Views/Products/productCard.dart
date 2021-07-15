import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatefulWidget {
  final Product data;
  final bool isAdmin;
  ProductCard(this.data, this.isAdmin, {Key key}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState(this.data, this.isAdmin);
}

class _ProductCardState extends State<ProductCard> {
  final Product data;
  final bool isAdmin;
  _ProductCardState(this.data, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
         leading: Icon(Icons.bookmark_border),
        title: RichText(
            text: TextSpan(
                text: '${data.name}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(Colors.black.value)),
            )),
        subtitle: RichText(
            text: TextSpan(
           text: '\$${data.price}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(Colors.black45.value)),
        )),
        // onTap: () async {
        //   if (isAdmin) {
        //     //Si es admin ver tiendas
        //     Navigator.pushNamed(context, "/Store",
        //         arguments: StoreViewParams(data.id, isAdmin));
        //   } else {
        //     // Navigator.pushNamed(context, "/Home",
        //     //     arguments: StoreViewParams(data.id, isAdmin));
        //   }
        // },
        onLongPress: () async {
          String nameValue;
          double priceValue;
          if (isAdmin) {
            alertInputDiag(context, "Editar Producto", "Nombre del producto",
                    data.name, "Nombre para el producto",
                    keyboard: TextInputType.text)
                .then((value) {
                  if (value == null) return;
                  else nameValue = value;
                  
                  alertInputDiag(context, "Editar Producto", "Precio del producto",
                          data.name, "Precio para el producto",
                          keyboard: TextInputType.number)
                      .then((value) {
                        if (value == null) return;
                        else priceValue = double.parse(value);

                        if(nameValue != null && priceValue != null)
                          _editProduct(widget.data.id, nameValue, priceValue);
                      });
                  
                });
                
          }
        },
      ),
      new Divider(
        height: 2.0,
      ),
    ])));
  }

  _editProduct(int id, String name, double price) async {
    BlocProvider.of<ProductsBloc>(context).add(EditProduct(id, name, price));
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }
}
