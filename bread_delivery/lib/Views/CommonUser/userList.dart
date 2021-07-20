import 'package:bread_delivery/BLOC/User/bloc/user_bloc.dart';
import 'package:bread_delivery/CommonWidgets/deleteDialog.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'aproveUser.dart';

class UserList extends StatefulWidget {
  final String title;
  UserList(this.title, {Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.Register).then((_) {
              _getUsers();
            });
          },
          child: Icon(Icons.add),
        ),
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) snackBar(context, state.toString());
          },
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UsersLoaded)
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  _getUsers();
                },
                child: ListView.separated(
                    itemCount: state.users.length,
                    separatorBuilder: (_, __) => Divider(
                        height: 1, color: Theme.of(context).accentColor),
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: ValueKey(state.users[index].userName),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {},
                          confirmDismiss: (direction) async {
                            final result = await showDialog(
                                    context: context,
                                    builder: (_) => DeleteDialog()) ??
                                false;
                            if (result) {
                              _deleteUser(state.users[index].userName);
                            }
                            return result;
                          },
                          background: Container(
                            color: Colors.red,
                            padding: EdgeInsets.only(left: 16),
                            child: Align(
                              child: Icon(Icons.delete, color: Colors.white),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          child: ListTile(
                            leading: state.users[index].aproved
                                ? Icon(
                                    Icons.verified_user,
                                    color: Color(Colors.green.value),
                                  )
                                : Icon(
                                    Icons.supervised_user_circle_sharp,
                                    color: Color(Colors.amber.value),
                                  ),
                            title: RichText(
                              text: TextSpan(
                                text: state.users[index].name,
                                style: !state.users[index].aproved
                                    ? TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                              ),
                            ),
                            subtitle: RichText(
                                text: TextSpan(
                                    text:
                                        "Nompre de Usuario: ${state.users[index].userName}\n",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    children: [
                                  TextSpan(
                                    text:
                                        "${(state.users[index].userType == 1) ? "Administrador" : "Usuario"}",
                                    style: !state.users[index].aproved
                                        ? TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ])),
                            onTap: () async {
                              final bool result = await showDialog(
                                      context: context,
                                      builder: (_) => AproveUser()) ??
                                  false;
                              if (result) {
                                _approveUser();
                              }
                            },
                            onLongPress: () async {
                              print("Long Press");
                              //TODO admin can change password?
                            },
                          ));
                    }),
              );
            return LoadingScreen();
          }),
        ));
  }

  _getUsers() async {
    BlocProvider.of<UserBloc>(context).add(GetUsers());
  }

  _deleteUser(String id) async {
    BlocProvider.of<UserBloc>(context).add(DeleteUser(id));
    _getUsers();
  }

  _approveUser() async {
    BlocProvider.of<UserBloc>(context).add(ApproveUser());
    _getUsers();
  }
}
