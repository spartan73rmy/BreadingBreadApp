import 'package:bread_delivery/BLOC/User/bloc/user_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[],
        ),
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
        })));
  }

  Widget registerScreen() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(25.0),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Icon(Icons.supervised_user_circle, size: 100)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: InputField("Nombre Completo", _nombreController,
                _nombreError, TextInputType.emailAddress),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: InputField("Usuario", _userNameController, _userError,
                TextInputType.emailAddress),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: PasswordField(
              "Constraseña",
              _passwordController,
              _obscureText,
              _passwordError,
              _togglePassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DropdownButton(
              hint: _selectedPermission == null
                  ? Text('Selecciona una opcion')
                  : Text(
                      _selectedPermission,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.blue),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Text(
              "Una vez te registres pide a tu administrador su aprobacion para poder usar la aplicacion",
              style: TextStyle(color: Color(Colors.black54.value)),
            ),
          ),
          FloatingActionButton.extended(
              icon: Icon(Icons.supervised_user_circle),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
                if (_isValid()) {
                  await _saveData();
                }
              },
              label: Text("Registrar")),
        ],
      ),
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

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
