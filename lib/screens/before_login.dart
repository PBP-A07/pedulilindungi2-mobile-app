import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedulilindungi2_mobile_app/screens/after_login.dart';
import 'package:account/screens/sign_in.dart';
import 'package:account/screens/sign_up.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePage createState() => _WelcomePage();
}


class _WelcomePage extends State<WelcomePage> {
  @override
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Flutter Horizontal Swipe Example'),
      // ),
      body: Center(
        child: PageView(controller: controller,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/pict4.png"),
                  fit: BoxFit.cover),
                  
            ),
            // color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Selamat", 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 25,
                        fontWeight: FontWeight.bold 
                      ),
                    ), 
                    Text("datang, ", 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 25,
                        fontWeight: FontWeight.bold 
                      ),
                    ), 
                    SizedBox(height: 25,),
                    Text("Pedulilindungi2.0 merupakan karya kelompok A07 dalam mata kuliah PBP yang bertujuan untuk mempermudah masyarakat dalam mendaftarkan diri dalam program vaksinasi.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    SizedBox(height: 50,),
                    Text(">>>>>",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12
                      ),
                    ),
                  ],
                ) 
            )
            
            
          ),
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/images/pict5.jpg"), width: 300,),
                SizedBox(height: 20,),
                Text("Masuk untuk melihat forum dan mendaftar vaksinasi",
                textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SigninPage(title: "PeduliLindungi2.0")),
                      );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  elevation: 10,
                  splashColor: Colors.lightBlue[100],
                  child: Ink(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient: new LinearGradient(
                        colors: <Color>[Colors.blue.shade600, Colors.deepPurple.shade300,],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                    child: new Text("Masuk", style: TextStyle(
                      color: Colors.white,
                    )),
                  ),
                ),
                SizedBox(height:20),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SignupPage(title: "PeduliLindungi2.0")),
                      );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  elevation: 10,
                  splashColor: Colors.lightBlue[100],
                  child: Ink(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient: new LinearGradient(
                        colors: <Color>[Colors.blue.shade600, Colors.deepPurple.shade300,],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                    child: new Text("Daftar", style: TextStyle(
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],)        
      ),
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
