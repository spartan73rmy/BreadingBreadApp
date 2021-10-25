import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final String placeHolder;
  final bool obscureText;
  final String passwordError;
  final VoidCallback togglePassword;
  PasswordField(this.placeHolder, this.passwordController, this.obscureText,
      this.passwordError, this.togglePassword);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), //color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 5, // blur radius
                        offset: Offset(0, 1),
                      )
                    ]),
                child: TextField(
                    controller: passwordController,
                    obscureText: obscureText,
                    style: TextStyle(color: Color(0xFF674023), fontSize: 20),
                    cursorColor: Color(0xFF674023),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        border: InputBorder.none,
                        hintText: placeHolder,
                        hintStyle:
                            TextStyle(color: Color(0xFF674023), fontSize: 20),
                        errorText: passwordError,
                        suffixIcon: GestureDetector(
                            onTap: togglePassword,
                            child: Icon(Icons.remove_red_eye,
                                color: Color(0xFF674023))))))
          ],
        ));
  }
}
