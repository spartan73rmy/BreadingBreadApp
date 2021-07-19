import 'package:bread_delivery/BLOC/Promotions/bloc/promotions_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(Icons.event_available),
        title: RichText(
            text: TextSpan(
                text: 'Nombre: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(Colors.black.value)),
                children: <TextSpan>[
              TextSpan(
                  text: '${data.idPromo}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(Colors.black.value)))
            ])),
        onTap: () async {
          if (isAdmin) {
            Navigator.pushNamed(context, Routes.Stores,
                arguments: StoreViewParams(data.idPromo, isAdmin));
          }
        },
        onLongPress: () async {
          if (isAdmin) {
            //Todo: Add Dialog to edit

          }
        },
      ),
      new Divider(
        height: 2.0,
      ),
    ])));
  }

  _editPromotion(int idPromo, int idProducto, int cantitySaleMin, int saleMin,
      int cantityFree, int discount, bool active) async {
    BlocProvider.of<PromotionsBloc>(context).add(EditPromotion(idPromo,
        idProducto, cantitySaleMin, saleMin, cantityFree, discount, active));
    BlocProvider.of<PromotionsBloc>(context).add(GetPromotions());
  }
}
