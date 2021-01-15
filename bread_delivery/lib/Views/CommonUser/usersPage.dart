import 'package:bread_delivery/BLOC/User/bloc/user_bloc.dart';
import 'package:bread_delivery/Services/User/userRepository.dart';
import 'package:bread_delivery/Views/CommonUser/userList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  final String title;

  const UserPage(this.title, {Key key}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserBloc(UserRepository()),
        child: UserList(widget.title));
  }
}
