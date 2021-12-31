library daftar_vaksin;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedulilindungi2_mobile_app/screens/after_login.dart';
import 'dart:convert';
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
  Map data = {};


  // void printPilihan(){
  //   print("Kota: " + _kotaChoose);
  //   print("Tanggal: " + _tanggalChoose);
  //   print("Jenis Vaksin: " + _jenisVaksinChoose);
  //   print("Tempat: " + _tempatChoose);
  // }

  Future<String> postData(CookieRequest request) async {
    request.isBiodata = true;
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/daftar-vaksin/flutter/daftar-vaksin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'kota': _kotaChoose,
          'tanggal': _tanggalChoose,
          'jenisVaksin': _jenisVaksinChoose,
          'tempat': _tempatChoose,
          'place': _tempatChoose,
          'penerima': request.username
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData["msg"];
  }

  Future<Map<String, dynamic>> fetchData() async {

    String url = 'http://10.0.2.2:8000/daftar-vaksin/flutter/get-data-penyedia';

    try {
      Map<String, dynamic> extractedData = {};

      final response = await http.get(Uri.parse(url));
      extractedData['penyedia'] = jsonDecode(response.body);
      data = extractedData;

      return extractedData;
    }

    catch (error) {
      // print(error);
      return {"Error" : "Sorry"};
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
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
              items: data['penyedia'][0]['fields']['kota'].map<DropdownMenuItem<String>>((String valueItem) {
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
              items: data['penyedia'][0]['fields']['tanggal'].map<DropdownMenuItem<String>>((String valueItem) {
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
              items: data['penyedia'][0]['fields']['jenis_vaksin'].map<DropdownMenuItem<String>>((String valueItem) {
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
              items: data['penyedia'][0]['fields']['tempat'].map<DropdownMenuItem<String>>((String valueItem) {
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

