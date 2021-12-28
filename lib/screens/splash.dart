import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedulilindungi2_mobile_app/screens/before_login.dart';


class SplashPage extends StatefulWidget {
  @override
  _MySplashPage createState() => _MySplashPage();
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => WelcomePage(),
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
	  Timer(Duration(seconds: 3),
		  () => Navigator.of(context).push(_createRoute())
		);
  }

  @override
  Widget build(BuildContext context) {
    return Material (
      child :Container(
        color: Colors.blue,
        child: Center(
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

// class SecondScreen extends StatelessWidget {
// @override
// Widget build(BuildContext context) {
// 	return Scaffold(
// 	appBar: AppBar(title:Text("GeeksForGeeks")),
// 	body: Center(
// 		child:Text("Home page",textScaleFactor: 2,)
// 	),
// 	);
// }
// }
