

import 'package:bread_delivery/BLOC/UserSale/bloc/usersales_bloc.dart';
import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'ActivePathsCard.dart';

class ActivePathsList extends StatefulWidget {
  final bool isAdmin;
  ActivePathsList(this.isAdmin, {Key key}) : super(key: key);

  @override
  _ActivePathsListState createState() => _ActivePathsListState();
}

class _ActivePathsListState extends State<ActivePathsList> {
  Future<List<ActivePath>> data;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  
  @override
  void initState(){
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text("Rutas activas"), actions: <Widget>[
            IconButton(onPressed: (){}, icon: Icon(Icons.router))
          ]),
          body: BlocListener<UserSalesBloc,UserSalesState>(
            listener: (context,state) => {
              if(state is UserSalesError)
              snackBar(context, state.toString())
            },
            child: BlocBuilder<UserSalesBloc,UserSalesState>(
              builder: (context,state){
                if(state is ActivePathsLoaded)
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async{
                    _getData();
                  },
                  child: ListView.builder(
                    itemCount: state.paths.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        child: ActivePathCard(state.paths[index], widget.isAdmin),
                      );
                    },
                  ),
                );
                return MessageScreen();
              }
            ),
          ),
        )
      ],
    );
  }

  _getData() async {
    _refreshIndicatorKey.currentState?.show();
    BlocProvider.of<UserSalesBloc>(context).add(GetActivePaths());
  }
}