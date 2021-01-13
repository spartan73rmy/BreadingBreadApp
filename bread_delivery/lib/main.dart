import 'package:bread_delivery/BLOC/Login/bloc/login_bloc.dart';
import 'package:bread_delivery/Home/homePage.dart';
import 'package:bread_delivery/Services/Cuenta/accountRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Login/login.dart';
import 'Router/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bread',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => LoginBloc(AccountRepository()),
        child: Login(),
      ),
      routes: Routes.routes,
    );
  }
}
