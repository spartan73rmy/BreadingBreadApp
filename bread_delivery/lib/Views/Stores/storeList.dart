import 'package:bread_delivery/BLOC/Store/bloc/store_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/Store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'storeCard.dart';

class StoreList extends StatefulWidget {
  final bool isAdmin;
  StoreList(this.isAdmin);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  int idPath = 1;
  Future<List<Stores>> data;
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
        appBar: AppBar(title: Text("Tiendas"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.store),
            onPressed: () {},
          )
        ]),
        body: BlocListener<StoreBloc, StoreState>(
            listener: (context, state) =>
                {if (state is StoreError) snackBar(context, state.toString())},
            child:
                BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
              if (state is StoresLoaded)
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: ListView.builder(
                        itemCount: state.stores.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: ValueKey(state.stores[index].id),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {},
                              confirmDismiss: (direction) async {
                                final result = await showDialog(
                                        context: context,
                                        builder: (_) => DeleteDialog()) ??
                                    false;
                                if (result) {
                                  _deleteStore(state.stores[index].id);
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
                              child: StoreCard(
                                  state.stores[index], isAdmin, idPath));
                        }));
              return LoadingScreen();
            })),
        floatingActionButton: isAdmin
            ? FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  //If is valid add to list else return
                  alertInputDiag(context, "Agregar Tienda",
                          "Nombre de la tienda", "", "Nombre para la tienda",
                          keyboard: TextInputType.text)
                      .then((value) {
                    if (value == null) return;
                    bool isValid = value != null;
                    if (isValid) {
                      _addStore(value);
                    }
                  });
                },
                label: Text("Tienda"))
            : Container());
  }

  _addStore(String name) async {
    BlocProvider.of<StoreBloc>(context).add(AddStore(name));
  }

  _deleteStore(int id) async {
    BlocProvider.of<StoreBloc>(context).add(DeleteStore(id));
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<StoreBloc>(context).add(GetStores(idPath));
  }
}
