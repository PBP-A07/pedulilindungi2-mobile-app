library daftar_vaksin;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pedulilindungi2_mobile_app/screens/after_login.dart';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';


class DaftarVaksin extends StatefulWidget {

  const DaftarVaksin({Key? key}) : super(key: key);

  @override
  State<DaftarVaksin> createState() => _DaftarVaksinState();
}

class _DaftarVaksinState extends State<DaftarVaksin> {
  String _kotaChoose = "Kota";
  String _tanggalChoose = "Tanggal";
  String _jenisVaksinChoose = "Jenis Vaksin";
  String _tempatChoose = "Tempat";


  // void printPilihan(){
  //   print("Kota: " + _kotaChoose);
  //   print("Tanggal: " + _tanggalChoose);
  //   print("Jenis Vaksin: " + _jenisVaksinChoose);
  //   print("Tempat: " + _tempatChoose);
  // }

  Future<String> postData(CookieRequest request) async {
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/daftar-vaksin/flutter/daftar-vaksin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'kota': _kotaChoose,
          'tanggal': _tanggalChoose,
          'jenis': _jenisVaksinChoose,
          'tempat': _tempatChoose,
          'place': _tempatChoose,
          'penerima': request.username
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (context) =>
          const MyHomePage()));

    return extractedData["msg"];
  }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Daftar Vaksin", style: TextStyle(fontSize: 24.0)),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: const SizedBox(),
              style: const TextStyle(
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
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: const SizedBox(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              value: _tanggalChoose,
              onChanged: (String? newValue) {
                setState(() {
                  _tanggalChoose = newValue!;
                });
              },
              items: <String>["Tanggal", "2022-01-16", "2022-01-17", "2022-01-18", "2022-01-19", "2022-01-20"].map<DropdownMenuItem<String>>((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: const SizedBox(),
              style: const TextStyle(
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
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.grey,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
              underline: const SizedBox(),
              style: const TextStyle(
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
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff3562FF)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Text("Daftar Vaksinasi", style: TextStyle(fontSize: 16.0)),
                        ]
                    )
                ),
                onPressed: () => {
                  postData(request)
                },
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Text("Kembali ke Menu Utama", style: TextStyle(fontSize: 16.0)),
                        ]
                    )
                ),
                onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      const MyHomePage()),
                  )
                },
            ),
          ),

        ],
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
    );
  }
}

