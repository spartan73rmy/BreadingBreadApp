import '../BLOC/Login/bloc/login_bloc.dart';
import '../CommonWidgets/inputField.dart';
import '../CommonWidgets/loadingScreen.dart';
import '../CommonWidgets/passField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  TextEditingController _userNameController, _passwordController;
  String _emailError, _passwordError;

  @override
  void initState() {
    super.initState();
    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Register()),
              // );
            },
          )
        ]),
        key: _scaffoldKey,
        body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoadingLogin) return LoadingScreen();
          if (state is Error) return AlertDialog(title: Text("Error"));
          if (state is SuccessLogin)
            return Container(); //TODO add redirect or something
          return Padding(
              padding:
                  const EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  Icon(Icons.weekend),
                  InputField("Usuario", _userNameController, _emailError,
                      TextInputType.emailAddress),
                  PasswordField(
                    passwordController: _passwordController,
                    obscureText: _obscureText,
                    passwordError: _passwordError,
                    togglePassword: _togglePassword,
                  ),
                  RaisedButton(
                      child: Text("Iniciar Sesion"),
                      onPressed: () => {_doLogin()})
                ],
              )));
        }));
  }

  _doLogin() {
    BlocProvider.of<LoginBloc>(context).add(DoLogin("Admin", "123"));
  }

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
