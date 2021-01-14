import 'package:bread_delivery/Views/CommonUser/userList.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final String title;

  const UserPage(this.title, {Key key}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return UserList(widget.title);
  }
}
