library daftar_vaksin;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const DaftarVaksin());
}

class DaftarVaksin extends StatelessWidget {
  const DaftarVaksin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedulilindungi2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const DaftarVaksinState(title: 'DAFTAR VAKSIN'),
    );
  }
}


class DaftarVaksinState extends StatefulWidget {

  const DaftarVaksinState({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DaftarVaksinState> createState() => _DaftarVaksinState();
}

class _DaftarVaksinState extends State<DaftarVaksinState> {
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
    return Scaffold(
      appBar: AppBar(
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

