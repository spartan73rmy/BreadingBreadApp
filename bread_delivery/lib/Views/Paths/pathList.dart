import 'package:bread_delivery/BLOC/Paths/bloc/paths_bloc.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'pathCard.dart';

class PathList extends StatefulWidget {
  PathList();

  @override
  _PathListState createState() => _PathListState();
}

class _PathListState extends State<PathList> {
  Future<List<Paths>> data;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PathsBloc, PathsState>(
        listener: (context, state) =>
            {if (state is PathsError) snackBar(context, state.toString())},
        child: BlocBuilder<PathsBloc, PathsState>(builder: (context, state) {
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
                              setState(() {
                                data = _deletePath(index);
                              });
                            }
                            return result;
                          },
                          background: Container(
                            color: Colors.blue,
                            padding: EdgeInsets.only(left: 16),
                            child: Align(
                              child: Icon(Icons.delete, color: Colors.white),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          child: PathCard((state.paths[index])));
                    }));
          else
            return LoadingScreen();
        }));
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<PathsBloc>(context).add(GetPaths());
  }

  Future<List<Paths>> _deletePath(int index) async {}
}
