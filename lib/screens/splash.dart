import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedulilindungi2_mobile_app/screens/before_login.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _MySplashPage createState() => _MySplashPage();
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const WelcomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(3.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _MySplashPage extends State<SplashPage> {
  @override
  void initState() {
	  super.initState();
	  Timer(const Duration(seconds: 3),
		  () => Navigator.of(context).push(_createRoute())
		);
  }

  @override
  Widget build(BuildContext context) {
    return Material (
      child :Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            "Pedulilindungi2.0",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal
            ),
          ),
        ),
      )
    );
  }
}
