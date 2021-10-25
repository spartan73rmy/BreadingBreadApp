import 'package:bread_delivery/BLOC/Paths/bloc/paths_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'pathCard.dart';

class PathList extends StatefulWidget {
  final bool isAdmin;
  PathList(this.isAdmin);

  @override
  _PathListState createState() => _PathListState();
}

class _PathListState extends State<PathList> {
  Future<List<Paths>> data;
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
        appBar: AppBar(title: Text("Rutas"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alt_route_rounded),
            onPressed: () {},
          )
        ]),
        body: BlocListener<PathsBloc, PathsState>(
            listener: (context, state) =>
                {if (state is PathsError) snackBar(context, state.toString())},
            child:
                BlocBuilder<PathsBloc, PathsState>(builder: (context, state) {
              if (state is PathsLoaded)
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
                                  _deletePath(state.paths[index].id);
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
            })),
        floatingActionButton: isAdmin
            ? FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  //If is valid add to list else return
                  alertInputDiag(context, "Agregar Ruta", "Nombre de la ruta",
                          "", "Nombre para la ruta",
                          keyboard: TextInputType.text)
                      .then((value) {
                    if (value == null) return;
                    bool isValid = value != null;
                    if (isValid) {
                      _addPath(value);
                    }
                  });
                },
                label: Text("Ruta"))
            : Container());
  }

  _addPath(String name) async {
    BlocProvider.of<PathsBloc>(context).add(AddPath(name));
    BlocProvider.of<PathsBloc>(context).add(GetPaths());
  }

  _deletePath(int id) async {
    BlocProvider.of<PathsBloc>(context).add(DeletePath(id));
    BlocProvider.of<PathsBloc>(context).add(GetPaths());
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<PathsBloc>(context).add(GetPaths());
  }
}
