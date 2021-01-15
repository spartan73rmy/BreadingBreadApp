import 'package:bread_delivery/BLOC/User/bloc/user_bloc.dart';
import 'package:bread_delivery/Services/User/userRepository.dart';
import 'package:bread_delivery/Views/CommonUser/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserPage extends StatefulWidget {
  final String title;
  RegisterUserPage(this.title, {Key key}) : super(key: key);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            create: (_) => UserBloc(UserRepository()),
            child: Register(widget.title)));
  }
}
