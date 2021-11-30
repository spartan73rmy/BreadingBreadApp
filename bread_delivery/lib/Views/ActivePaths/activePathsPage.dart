

import 'package:bread_delivery/BLOC/UserSale/bloc/usersales_bloc.dart';
import 'package:bread_delivery/Services/UserSale/userSaleRespository.dart';
import 'package:bread_delivery/Views/ActivePaths/activePathsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivePathsPage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const ActivePathsPage(this.title, this.isAdmin, {Key key}) : super(key: key);
  @override
  _ActivePathsState createState() => _ActivePathsState();
}

class _ActivePathsState extends State<ActivePathsPage>{
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (_) => UserSalesBloc(UserSalesRepository()),
      child: ActivePathsList(widget.isAdmin)
    );
  }
}