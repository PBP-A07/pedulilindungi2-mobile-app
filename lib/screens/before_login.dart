import 'package:flutter/material.dart';
import 'package:account/screens/sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

const _signUpURL = 'http://localhost:8000/auth/';

void _launchURL() async => await canLaunch(_signUpURL)
    ? await launch(_signUpURL)
    : throw 'Could not launch $_signUpURL';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  final controller = PageController(initialPage: 0);
  int bottomSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PageView(
        controller: controller,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: <Widget>[
          AboutPage(
            onButtonPressed: () => controller.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            ),
          ),
          const ToSignInPage(),
        ],
      )),
    );
  }
}


class AboutPage extends StatelessWidget {

  final VoidCallback onButtonPressed;

  const AboutPage({required this.onButtonPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pict4.png"),
              fit: BoxFit.cover),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      elevation: 10,

                    ),
                    child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.blue.shade600,
                              Colors.deepPurple.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),

                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: const Icon(Icons.arrow_forward)),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Selamat",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "datang, ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Pedulilindungi2.0 merupakan karya kelompok A07 dalam mata kuliah PBP yang bertujuan untuk mempermudah masyarakat dalam mendaftarkan diri dalam program vaksinasi.",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          )
        )
      ),
    );
  }
}

class ToSignInPage extends StatelessWidget {
  const ToSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage("assets/images/pict5.jpg"),
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Masuk untuk melihat forum dan mendaftar vaksinasi",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
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
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.blue.shade600,
                      Colors.deepPurple.shade300,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                child: const Text("Masuk",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchURL();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                padding: const EdgeInsets.all(0.0),
                elevation: 10,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.blue.shade600,
                      Colors.deepPurple.shade300,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                child: const Text("Daftar",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
