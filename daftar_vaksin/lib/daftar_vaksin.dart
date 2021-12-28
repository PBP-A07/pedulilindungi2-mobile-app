library daftar_vaksin;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedulilindungi2.0',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MyHomePage(title: 'DAFTAR VAKSIN'),
    );
  }
}


class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _kotaChoose = "Kota";
  String _tanggalChoose = "Tanggal";
  String _jenisVaksinChoose = "Jenis Vaksin";
  String _tempatChoose = "Tempat";

  void printPilihan(){
    print("Kota: " + _kotaChoose);
    print("Tanggal: " + _tanggalChoose);
    print("Jenis Vaksin: " + _jenisVaksinChoose);
    print("Tempat: " + _tempatChoose);
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              value: _kotaChoose,
              onChanged: (String? newValue) {
                setState(() {
                  _kotaChoose = newValue!;
                });
              },
              items: <String>["Kota", "Gambir", "Senen", "Tanah Abang", "Cengkareng", "Kebun Jeruk",  "Pasar Minggu", "Pancoran"].map<DropdownMenuItem<String>>((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              value: _tanggalChoose,
              onChanged: (String? newValue) {
                setState(() {
                  _tanggalChoose = newValue!;
                });
              },
              items: <String>["Tanggal", "16/11/2021", "17/11/2021", "18/11/2021", "19/11/2021", "20/11/2021"].map<DropdownMenuItem<String>>((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              value: _jenisVaksinChoose,
              onChanged: (String? newValue) {
                setState(() {
                  _jenisVaksinChoose = newValue!;
                });
              },
              items: <String>["Jenis Vaksin", "Sinovac", "AstraZeneca", "Sinopharm"].map<DropdownMenuItem<String>>((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              value: _tempatChoose,
              onChanged: (String? newValue) {
                setState(() {
                  _tempatChoose = newValue!;
                });
              },
              items: <String>["Tempat", "Jakarta Medical Center Hospital", "RSCM", "RS UI", "RSUD Kemayoran"].map<DropdownMenuItem<String>>((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 32, left: 16, right: 16),
            child: RaisedButton(
                color: Color(0xff3562FF),
                textColor: Colors.white,
                child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Daftar Vaksinasi", style: TextStyle(fontSize: 16.0)),
                        ]
                    )
                ),
                onPressed: () => {
                  printPilihan()
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                )
            ),
          ),


        ],
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
    );
  }
}

