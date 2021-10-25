import 'package:bread_delivery/BLOC/Store/bloc/store_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/drawerContent.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Entities/storePoint.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:bread_delivery/Views/Stores/selectStoreByPath.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'storeCard.dart';

class StoreList extends StatefulWidget {
  final StoreViewParams params;
  StoreList(this.params);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  int idPath;
  bool isAdmin;
  Future<List<Stores>> data;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  _initData() {
    if (isAdmin == null || idPath == null) {
      setState(() {
        isAdmin = widget.params.isAdmin;
        idPath = widget.params.idPath;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initData();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final StoreBloc block = BlocProvider.of<StoreBloc>(context);

    return Scaffold(
        drawer: DrawerContent(isAdmin: isAdmin),
        appBar: AppBar(title: Text("Tiendas"), actions: <Widget>[
          BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
            if (state is StoresLoaded)
              return IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.Map,
                        arguments: state.stores
                            .map((e) =>
                                StorePoint(e.name, e.id, LatLng(e.lat, e.lon)))
                            .toList());
                  });
            else
              return IconButton(icon: Icon(Icons.map), onPressed: () {});
          })
        ]),
        body: BlocListener<StoreBloc, StoreState>(
            listener: (context, state) => {
                  if (state is StoreError) snackBar(context, state.toString()),
                  if (state is StoreOperationCompleted) _getData(),
                },
            child:
                BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
              if (state is StoresLoaded) {
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: ListView.builder(
                        itemCount: state.stores.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return isAdmin
                              ? Dismissible(
                                  key: ValueKey(state.stores[index].id),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {},
                                  confirmDismiss: (direction) async {
                                    final result = await showDialog(
                                            context: context,
                                            builder: (_) => DeleteDialog()) ??
                                        false;
                                    if (result) {
                                      if (idPath != null)
                                        _deallocateStorePath(
                                            state.stores[index].id, idPath);
                                      else
                                        _deleteStore(state.stores[index].id);
                                    }
                                    return result;
                                  },
                                  background: Container(
                                    color: Colors.blue,
                                    padding: EdgeInsets.only(left: 16),
                                    child: Align(
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  child: StoreCard(
                                      state.stores[index], isAdmin, idPath))
                              : StoreCard(state.stores[index], isAdmin, idPath);
                        }));
              }
              return MessageScreen();
            })),
        floatingActionButton: Container(child:
            BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
          if (state is StoresLoaded) {
            return isAdmin
                ? FloatingActionButton.extended(
                    icon: Icon(Icons.add),
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (idPath != null) {
                        addStoresToPath(context, state.storesAvailable)
                            .then((value) {
                          print(value.length);
                          if (value == null) return;
                          _assignStoresToPath(value, idPath);
                        });
                      } else {
                        //If is valid add to list else return
                        alertInputDiag(
                                context,
                                "Agregar Tienda",
                                "Nombre de la tienda",
                                "",
                                "Nombre para la tienda",
                                keyboard: TextInputType.text)
                            .then((value) {
                          if (value == null) return;
                          bool isValid = value != null;
                          if (isValid) {
                            _addStore(value);
                          }
                        });
                      }
                    },
                    label: Text("Tienda"))
                : FloatingActionButton.extended(
                    icon: Icon(Icons.qr_code_scanner),
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      Navigator.of(context).pushNamed(Routes.Qr,
                          arguments: UserSaleViewParams(widget.params,
                              selectedStore: null,
                              stores: state.storesAvailable,
                              products: null));
                    },
                    label: Text("Escanear"));
          } else
            return FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () async {},
                label: Text("Tienda"));
        })));
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

  _assignStoresToPath(List<Store> value, int idPath) async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<StoreBloc>(context).add(AssignStoreToPath(value, idPath));
  }

  _deallocateStorePath(int idStore, int idPath) async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<StoreBloc>(context)
        .add(DeallocateStoreToPath(idStore, idPath));
  }
}
