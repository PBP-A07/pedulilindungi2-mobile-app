import 'package:account/screens/sign_up.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
// import 'package:studi_kasus/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;
  final bool isKembali;
  final bool isSignUp;
  final bool isSignIn;
  final dynamic request;
  final String? username;
  final String? password;

  void login() async {
    // 'username' and 'password' should be the values of the user login form.
    final response =
        await request.login("http://127.0.0.1:8000/auth/flutter-login/", {
      'username': username,
      'password': password,
    });
    // if (request.loggedIn) {
    //   // Code here will run if the login succeeded.
    // } else {
    //   // Code here will run if the login failed (wrong username/password).
    // }
  }

  const CustomPrimaryButton(
      {Key? key,
      required this.buttonColor,
      required this.textValue,
      required this.textColor,
      required this.isKembali,
      required this.isSignUp,
      required this.isSignIn,
      this.request,
      this.username,
      this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14.0),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // if (isKembali) {
              //   Navigator.pushReplacement(
              //     context,MaterialPageRoute(
              //               builder: (context) =>
              //                   const (title: "PeduliLindungi2.0")), // Ini mestinya balik ke homepage lagi
              //         );
              //   );
              if (isSignIn) {
                login();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SignupPage(title: "PeduliLindungi2.0")),
                );
              }
            },
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Text(
                textValue,
                style: heading5.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
