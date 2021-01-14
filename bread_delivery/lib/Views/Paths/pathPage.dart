import 'package:bread_delivery/BLOC/Paths/bloc/paths_bloc.dart';
import 'package:bread_delivery/Services/Path/pathRepository.dart';
import 'package:bread_delivery/Views/Paths/pathList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PathsPage extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const PathsPage(this.title, this.isAdmin, {Key key}) : super(key: key);
  @override
  _PathsPageState createState() => _PathsPageState();
}

class _PathsPageState extends State<PathsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PathsBloc(PathRepository()),
        child: PathList(widget.isAdmin));
  }
}
