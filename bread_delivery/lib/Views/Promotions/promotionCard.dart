import 'package:bread_delivery/BLOC/Promotions/bloc/promotions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionCard extends StatefulWidget {
  final Promotion data;
  final bool isAdmin;
  PromotionCard(this.data, this.isAdmin, {Key key}) : super(key: key);

  @override
  _PromotionCardState createState() =>
      _PromotionCardState(this.data, this.isAdmin);
}

class _PromotionCardState extends State<PromotionCard> {
  final Promotion data;
  final bool isAdmin;
  _PromotionCardState(this.data, this.isAdmin);
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String cardText(Promotion d) {
    String t1 = (d.cantitySaleMin != 0)
      ? "en la compra de ${d.cantitySaleMin} panes "
      : "a partir de \$${d.saleMin} ";
    
    String t2 = (d.cantityFree != 0) 
      ? "se lleva ${d.cantityFree} gratis"
      : "se descuenta un %${d.discount}";

      return t1 + t2;
    }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(Icons.verified, color: Colors.amber[900]), //TODO: Verificar si esta activa la promo o no y cambiar el color en base a eso
        title: RichText(
            text: TextSpan(
                text: 'Promo: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(Colors.black.value)),
                children: <TextSpan>[
              TextSpan(
                  text: '${data.idPromo} - ${cardText(data)}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(Colors.black.value)))
            ])),
        // onTap: () async {
        //   if (isAdmin) {
        //   }
        // },
        onLongPress: () async {
          if (isAdmin) {
            await showDialogWithFields(context);
          }
        },
      ),
      new Divider(
        height: 2.0,
      ),
    ])));
  }

  _editPromotion(int idPromo, int idProducto, int cantitySaleMin,
      double saleMin, int cantityFree, int discount, bool active) async {
    BlocProvider.of<PromotionsBloc>(context).add(EditPromotion(idPromo,
        idProducto, cantitySaleMin, saleMin, cantityFree, discount, active));
    BlocProvider.of<PromotionsBloc>(context).add(GetPromotions());
  }

  Future<void> showDialogWithFields(
    BuildContext context,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var DiscountController = TextEditingController();
          var TypeController = TextEditingController();
          bool isDiscount = (data.discount != 0);
          bool isPerQuantity = (data.cantitySaleMin != 0);
          bool isActive = true;
          DiscountController.text = (isDiscount)
              ? data.discount.toString()
              : data.cantityFree.toString();
          TypeController.text = (isPerQuantity)
              ? data.cantitySaleMin.toString()
              : data.saleMin.toString();

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Editar Promocion'),
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
                                : "Venta minima (\$)"),
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "El campo no puede estar vacio";
                        },
                      ),
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
                                : "Producto Gratis"),
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "El campo no puede estar vacio";
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Activa"),
                          Switch(
                              value: isActive,
                              onChanged: (value) {
                                setState(() {
                                  isActive = value;
                                });
                              }),
                        ],
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
                      var Type = TypeController.text;
                      var Discount = DiscountController.text;
                      int idPromo = data.idPromo;
                      int idProducto = data.idProduct;
                      int cantitySaleMin =
                          (isPerQuantity) ? int.parse(Type) : 0;
                      double saleMin =
                          (!isPerQuantity) ? double.parse(Type) : 0;
                      int cantityFree = (!isDiscount) ? int.parse(Discount) : 0;
                      int discount = (isDiscount) ? int.parse(Discount) : 0;
                      bool active = isActive;
                      await _editPromotion(idPromo, idProducto, cantitySaleMin,
                          saleMin, cantityFree, discount, active);
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
