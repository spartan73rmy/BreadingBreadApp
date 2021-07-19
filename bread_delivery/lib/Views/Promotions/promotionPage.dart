import 'package:bread_delivery/BLOC/Promotions/bloc/promotions_bloc.dart';
import 'package:bread_delivery/Services/Promotion/promotionRepository.dart';
import 'package:bread_delivery/Views/Promotions/promotionList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionsPage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const PromotionsPage(this.title, this.isAdmin, {Key key}) : super(key: key);
  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PromotionsBloc(PromotionRepository()),
        child: PromotionList(widget.isAdmin));
  }
}
