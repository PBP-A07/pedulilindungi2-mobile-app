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

  const CustomPrimaryButton(
      {Key? key,
      required this.buttonColor,
      required this.textValue,
      required this.textColor,
      required this.isKembali,
      required this.isSignUp,
      required this.isSignIn})
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
              // }
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
    ;
  }
}
