import 'package:bread_delivery/BLOC/Paths/bloc/paths_bloc.dart';
import 'package:bread_delivery/Services/Path/pathRepository.dart';
import 'package:bread_delivery/Views/Paths/pathList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PathsPage extends StatefulWidget {
  final String title;

  const PathsPage(this.title, {Key key}) : super(key: key);
  @override
  _PathsPageState createState() => _PathsPageState();
}

class _PathsPageState extends State<PathsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.alt_route_rounded),
          onPressed: () {},
        )
      ]),
      body: Container(
          child: BlocProvider(
        create: (_) => PathsBloc(PathRepository()),
        child: PathList(),
      )),
    );
  }
}
