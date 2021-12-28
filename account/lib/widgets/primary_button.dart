// ignore_for_file: avoid_print

import 'package:account/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import 'package:biodata/biodata_peserta.dart';
import 'package:biodata/biodata_penyedia.dart';

import '../theme.dart';
// import 'package:studi_kasus/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;
  final bool isKembali;
  final bool isSignUp;
  final bool isSignIn;
  final CookieRequest? request;
  final String? username;
  final String? password;

  dynamic login() async {
    // 'username' and 'password' should be the values of the user login form.
    final response =
        await request!.login("http://127.0.0.1:8000/auth/flutter-signin/", {
      'username': username,
      'password': password,
    });
    if (request!.loggedIn) {
      return response;
    } else {
      return response;
    }
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
            onTap: () async {
              // if (isKembali) {
              //   Navigator.pushReplacement(
              //     context,MaterialPageRoute(
              //               builder: (context) =>
              //                   const (title: "PeduliLindungi2.0")), // Ini mestinya balik ke homepage lagi
              //         );
              //   };
              if (isSignIn) {
                await login();
                print(request!.role);
                if (!request!.isBiodata) {
                  if (request!.role == "penerima") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BiodataPeserta()),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BiodataPenyedia()),
                    );
                  }
                } else {
                  print(request!.isBiodata);
                  // if(request!.role == "peserta") {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             const BiodataPeserta()),
                  //   );
                  // } else {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             const BiodataPenyedia()),
                  //   );
                  // }
                }
                //   // TODO : Al handle
                // }
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
