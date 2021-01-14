import 'package:bread_delivery/CommonWidgets/inputField.dart';
import 'package:bread_delivery/CommonWidgets/loadingScreen.dart';
import 'package:bread_delivery/CommonWidgets/passField.dart';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Entities/userType.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final String title;
  Register(this.title, {Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  bool _obscureText = true;
  TextEditingController _userNameController,
      _emailController,
      _passwordController,
      _nombreController,
      _aPaternoController,
      _aMaternoController;

  String _passwordError, _userError, _nombreError;
  String _selectedPermission;

  @override
  void initState() {
    super.initState();
    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _emailController = new TextEditingController();
    _nombreController = new TextEditingController();
    _aPaternoController = new TextEditingController();
    _aMaternoController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: _isLoading ? LoadingScreen() : registerScreen(),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
            icon: Icon(Icons.supervised_user_circle),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {
              if (_isValid()) {
                await saveData();
              }
            },
            label: Text("Registrar")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget registerScreen() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(25.0),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Icon(Icons.supervised_user_circle, size: 200)),
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
              passwordController: _passwordController,
              obscureText: _obscureText,
              passwordError: _passwordError,
              togglePassword: _togglePassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
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
          Text(
              "Una vez te registres pide a tu administrador su aprobacion para poder usar la aplicacion")
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
    if (_passwordController.text.isEmpty) {
      valid = false;
      setState(() {
        _passwordError = "Introduce una contraseña";
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

  Future<void> saveData() async {
    UserCreate user = new UserCreate(
        userName: _userNameController.text,
        password: _passwordController.text,
        name: _nombreController.text,
        userType: (_selectedPermission == UserType.admin)
            ? UserType.adminT
            : UserType.userT);
    print(user);
  }
}
