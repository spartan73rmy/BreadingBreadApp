import 'package:bread_delivery/BLOC/UserSale/bloc/usersales_bloc.dart';
import 'package:bread_delivery/Services/UserSale/userSaleRespository.dart';
import 'package:bread_delivery/Views/UserSales/userSalesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSalesPage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const UserSalesPage(this.title, this.isAdmin, {Key key}) : super(key: key);
  @override
  _UserSalesPageState createState() => _UserSalesPageState();
}

class _UserSalesPageState extends State<UserSalesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserSalesBloc(UserSalesRepository()),
        child: UserSaleList(widget.isAdmin));
  }
}
