import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:flutter/material.dart';

import 'aproveUser.dart';

class UserList extends StatefulWidget {
  final String title;
  UserList(this.title, {Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserCreate> res;
  @override
  void initState() {
    _fetchUsers();
    super.initState();
  }

  _fetchUsers() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/Register").then((_) {
              _fetchUsers();
            });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            return ListView.separated(
              itemCount: res.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Theme.of(context).primaryColor),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(res[index].userName),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {},
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        text: res[index].name,

                        // style: !res[index].aproved
                        style: true
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
                            text: "${res[index].userName}\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            children: [
                          TextSpan(
                            text:
                                "${(res[index].userType == 1) ? "Administrador" : "Usuario"}",
                            // style: !res[index].aproved
                            style: true
                                ? TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)
                                : TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                          ),
                        ])),
                    onTap: () async {
                      final result = await showDialog(
                          context: context, builder: (_) => AproveUser());

                      if (result) {}
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
