import 'package:bread_delivery/BLOC/Login/bloc/login_bloc.dart';
import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:bread_delivery/CommonWidgets/button_primary.dart';
import 'package:bread_delivery/CommonWidgets/inputField.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/passField.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/userType.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  final functionButton;

  Login({Key key, this.functionButton}) : super(key: key);

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

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _userRegister(context) {
    Navigator.pushNamed(
      context,
      Routes.Register,
    );
  }

  void _doLogin(context) {
    BlocProvider.of<LoginBloc>(context).add(
      DoLogin(_userNameController.text, _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) => {
                  if (state is ErrorLogin)
                    snackBar(context, state.toString())
                  else if (state is SuccessLogin)
                    Navigator.pushReplacementNamed(context, Routes.Home,
                        arguments: state.token.user.userType == UserType.adminT)
                },
            child:
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state is LoadingLogin) return LoadingScreen();
              return Stack(
                children: [
                  Background(),
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      body: SingleChildScrollView(
                          child: SafeArea(
                              child: Column(
                        children: [
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                            )),
                          ),
                          Container(
                            child: InputField("Usuario", _userNameController,
                                _emailError, TextInputType.emailAddress),
                            margin: EdgeInsets.only(bottom: 25),
                          ),
                          Container(
                            child: PasswordField(
                                "Contraseña",
                                _passwordController,
                                _obscureText,
                                _passwordError,
                                _togglePassword),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 130, bottom: 50),
                              child: TextButton(
                                style:
                                    TextButton.styleFrom(primary: Colors.white),
                                onPressed: () {},
                                child: Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: ButtonPrimary(
                                "login",
                                "Iniciar Sesión",
                                'assets/icons/access_icon.png',
                                25,
                                [15.0, 10.0, 5.0, 10.0],
                                [5.0, 10.0, 15.0, 10.0],
                                () => _doLogin(context)),
                          ),
                          Container(
                            child: ButtonPrimary(
                                "register",
                                "Registrarse",
                                'assets/icons/registration_icon.png',
                                25,
                                [15.0, 10.0, 10.0, 10.0],
                                [5.0, 10.0, 20.0, 10.0],
                                () => _userRegister(context)),
                          )
                        ],
                      ))))
                ],
              );
            })));
  }
}
