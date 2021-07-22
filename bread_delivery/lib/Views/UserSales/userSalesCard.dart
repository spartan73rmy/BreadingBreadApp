import 'package:bread_delivery/BLOC/UserSale/bloc/usersales_bloc.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PathCard extends StatefulWidget {
  final Path data;
  final bool isAdmin;
  PathCard(this.data, this.isAdmin, {Key key}) : super(key: key);

  @override
  _PathCardState createState() => _PathCardState(this.data, this.isAdmin);
}

class _PathCardState extends State<PathCard> {
  final Path data;
  final bool isAdmin;
  _PathCardState(this.data, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: data.selected
            ? Icon(Icons.not_interested)
            : Icon(Icons.event_available),
        title: RichText(
            text: TextSpan(
                text: 'Nombre: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(Colors.black.value)),
                children: <TextSpan>[
              TextSpan(
                  text: '${data.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(Colors.black.value)))
            ])),
        subtitle: RichText(
            text: TextSpan(
          text: data.selected ? 'Seleccionado' : 'Disponible',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(Colors.black45.value)),
        )),
        onTap: () async {
          _addUserSale(widget.data.id);
        },
      ),
      new Divider(
        height: 2.0,
      ),
    ])));
  }

  _addUserSale(int idPath) async {
    BlocProvider.of<UserSalesBloc>(context).add(AddUserSale(idPath));
    BlocProvider.of<UserSalesBloc>(context).add(GetUserSales());
  }
}
