import 'package:bread_delivery/BLOC/Store/bloc/store_bloc.dart';
import 'package:bread_delivery/Services/Store/storeRepository.dart';
import 'package:bread_delivery/Views/Stores/storeList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresPage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const StoresPage(this.title, this.isAdmin, {Key key}) : super(key: key);
  @override
  _StoresPageState createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => StoreBloc(StoreRepository()),
        child: StoreList(widget.isAdmin));
  }
}
