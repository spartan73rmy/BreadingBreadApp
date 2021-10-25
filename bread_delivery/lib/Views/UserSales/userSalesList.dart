import 'package:bread_delivery/BLOC/UserSale/bloc/usersales_bloc.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:bread_delivery/Views/UserSales/userSalesCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSaleList extends StatefulWidget {
  final bool isAdmin;
  UserSaleList(this.isAdmin);

  @override
  _UserSaleListState createState() => _UserSaleListState();
}

class _UserSaleListState extends State<UserSaleList> {
  Future<List<Path>> data;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool isAdmin;

  _isAdmin() {
    if (isAdmin == null) {
      setState(() {
        isAdmin = widget.isAdmin;
      });
    }
  }

  @override
  void initState() {
    _isAdmin();
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ruta de venta"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alt_route_rounded),
            onPressed: () {},
          )
        ]),
        body: BlocListener<UserSalesBloc, UserSalesState>(
            listener: (context, state) => {
                  if (state is UserSalesError)
                    snackBar(context, state.toString())
                  else if (state is UserSaleAssigned)
                    Navigator.pushReplacementNamed(context, Routes.Stores,
                        arguments: state.store) //Le decimos que es usuario
                },
            child: BlocBuilder<UserSalesBloc, UserSalesState>(
                builder: (context, state) {
              if (state is UserSalesLoaded)
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: ListView.builder(
                        itemCount: state.paths.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: ValueKey(state.paths[index].id),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {},
                              confirmDismiss: (direction) async {
                                final result = await showDialog(
                                        context: context,
                                        builder: (_) => DeleteDialog()) ??
                                    false;
                                if (result) {
                                  // _deleteUserSale(state.paths[index].id);
                                }
                                return result;
                              },
                              background: Container(
                                color: Colors.blue,
                                padding: EdgeInsets.only(left: 16),
                                child: Align(
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              child: PathCard(state.paths[index], isAdmin));
                        }));
              return MessageScreen();
            })));
  }

  // _deleteUserSale(int id) async {
  //   BlocProvider.of<UserSalesBloc>(context).add(DeleteUserSale(id));
  //   BlocProvider.of<UserSalesBloc>(context).add(GetUserSales());
  // }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<UserSalesBloc>(context).add(GetUserSales());
  }
}
