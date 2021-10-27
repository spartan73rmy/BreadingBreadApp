import 'package:bread_delivery/BLOC/Products/bloc/products_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/Entities/promotionViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
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
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
        onTap: () async {
          if (isAdmin) {
            Navigator.pushNamed(context, Routes.Promotions, arguments: PromotionViewParams(isAdmin, data));
          }
        },
        onLongPress: () async {
          if (isAdmin) {
            showDialogWithFields(context);
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

  Future<void> showDialogWithFields(
    BuildContext context,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var NameController = TextEditingController();
          var PriceController = TextEditingController();
          NameController.text = data.name;
          PriceController.text = data.price.toString();

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Editar Producto', textAlign: TextAlign.center,),
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
                      _editProduct(data.id, NewName, NewPrice);
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
