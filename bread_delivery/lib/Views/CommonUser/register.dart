import 'package:bread_delivery/BLOC/User/bloc/user_bloc.dart';
import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:bread_delivery/CommonWidgets/button_primary.dart';
import 'package:bread_delivery/CommonWidgets/alert.dart';
import 'package:bread_delivery/CommonWidgets/inputField.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/passField.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Entities/userType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  final String title;
  Register(this.title, {Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  TextEditingController _userNameController,
      _passwordController,
      _nombreController;

  String _passwordError, _userError, _nombreError;
  String _selectedPermission;

  @override
  void initState() {
    super.initState();
    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _nombreController = new TextEditingController();
  }

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Background(),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocListener<UserBloc, UserState>(listener: (context, state) {
            if (state is UserError) {
              snackBar(context, state.toString());
            }
            if (state is UserErrorV) {
              alertDiag(context, state?.e?.message, state?.e?.details);
            }
            if (state is UserOperationCompleted) {
              Navigator.pop(context);
            }
          }, child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UsersLoading) return LoadingScreen();
            return registerScreen();
          })))
    ]);
  }

  Widget registerScreen() {
    return Container(
      child: ListView(children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
          )),
        ),
        Column(
          children: [
            Container(
              child: InputField.onlyName("Nombre completo"),
              margin: EdgeInsets.only(bottom: 25),
            ),
            Container(
              child: InputField("Usuario", _userNameController, _nombreError,
                  TextInputType.emailAddress),
              margin: EdgeInsets.only(bottom: 25),
            ),
            Container(
              child: PasswordField("Contraseña", _passwordController,
                  _obscureText, _passwordError, _togglePassword),
              margin: EdgeInsets.only(bottom: 25),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.3), //color of shadow
                          spreadRadius: 3, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 5),
                        )
                      ]),
                  child: DropdownButton(
                    underline: Container(),
                    hint: _selectedPermission == null
                        ? Text(
                            'Seleccione puesto',
                            style: TextStyle(color: Colors.brown, fontSize: 20),
                          )
                        : Text(
                            _selectedPermission,
                            style: TextStyle(color: Colors.brown),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.brown, fontSize: 20),
                    items: [UserType.admin, UserType.user].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _selectedPermission = val;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: Text(
                    "Una vez te registres pide a tu administrador su aprobación para poder usar la aplicación",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: ButtonPrimary(
                'register',
                "Registrar usuario",
                'assets/icons/access_icon.png',
                25,
                [15.0, 10.0, 5.0, 10.0],
                [5.0, 10.0, 15.0, 10.0],
                () => {
                  if (_isValid()) {_saveData()}
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }

  _isValid() {
    bool valid = true;
    if (_selectedPermission == null) {
      valid = false;
    }
    if (_userNameController.text.isEmpty) {
      valid = false;
      setState(() {
        _userError = "Tu nombre de usuario, debe ser facil de recordar";
      });
    }
    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      valid = false;
      setState(() {
        _passwordError = "Introduce una contraseña valida, minimo 6 caracteres";
      });
    } else if (_passwordController.text.length < 6) {
      valid = false;
      setState(() {
        _passwordError = "Minimo 6 caracteres";
      });
    }

    if (_nombreController.text.isEmpty) {
      valid = false;
      setState(() {
        _nombreError = "Introduce tu nombre";
      });
    }

    return valid;
  }

  _saveData() async {
    UserCreate user = new UserCreate(
        userName: _userNameController.text,
        password: _passwordController.text,
        name: _nombreController.text,
        userType: (_selectedPermission == UserType.admin)
            ? UserType.adminT
            : UserType.userT);
    BlocProvider.of<UserBloc>(context).add(AddUser(user));
  }
}
