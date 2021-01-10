import '../CommonWidgets/inputField.dart';
import '../CommonWidgets/loadingScreen.dart';
import '../CommonWidgets/passField.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final String title;

  Login(this.title, {Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool _obscureText = true;
  TextEditingController _userNameController, _passwordController;
  String _emailError, _passwordError;

  @override
  void initState() {
    super.initState();
    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  Widget _loginScreen() {
    return new Container(
      child: new ListView(
        padding: const EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
        children: <Widget>[
          new Icon(Icons.weekend),
          new InputField("Usuario", _userNameController, _emailError,
              TextInputType.emailAddress),
          new PasswordField(
            passwordController: _passwordController,
            obscureText: _obscureText,
            passwordError: _passwordError,
            togglePassword: _togglePassword,
          ),
          // new LoginButton(text: "Log In", onPressed: _authenticateUser),
        ],
      ),
    );
  }

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
        body: _isLoading ? LoadingScreen() : _loginScreen());
  }
}
