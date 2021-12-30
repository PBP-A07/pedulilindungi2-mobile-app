import 'package:flutter/material.dart';
import 'package:account/screens/sign_in.dart';
import 'package:account/screens/sign_up.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  _WelcomePage createState() => _WelcomePage();
}


class _WelcomePage extends State<WelcomePage> {
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Selamat", 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 25,
                        fontWeight: FontWeight.bold 
                      ),
                    ), 
                    const Text("datang, ", 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 25,
                        fontWeight: FontWeight.bold 
                      ),
                    ), 
                    const SizedBox(height: 25,),
                    const Text("Pedulilindungi2.0 merupakan karya kelompok A07 dalam mata kuliah PBP yang bertujuan untuk mempermudah masyarakat dalam mendaftarkan diri dalam program vaksinasi.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 50,),
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
                const Image(image: AssetImage("assets/images/pict5.jpg"), width: 300,),
                const SizedBox(height: 20,),
                const Text("Masuk untuk melihat forum dan mendaftar vaksinasi",
                textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SigninPage(title: "PeduliLindungi2.0")),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    elevation: 10,
                    // splashColor: Colors.lightBlue[100],
                  ),
                  child: Ink(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient:  LinearGradient(
                        colors: <Color>[Colors.blue.shade600, Colors.deepPurple.shade300,],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                    child: const Text("Masuk", style: TextStyle(
                      color: Colors.white,
                    )),
                  ),
                ),
                const SizedBox(height:20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SignupPage(title: "PeduliLindungi2.0")),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    elevation: 10,
                    // splashColor: Colors.lightBlue[100],
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient: LinearGradient(
                        colors: <Color>[Colors.blue.shade600, Colors.deepPurple.shade300,],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                    child: const Text("Daftar", style: TextStyle(
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
