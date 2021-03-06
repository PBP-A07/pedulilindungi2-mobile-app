library tambah_vaksin;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';


class TambahVaksin extends StatefulWidget {
  const TambahVaksin({Key? key}) : super(key: key);
  @override
  _TambahVaksinState createState() => _TambahVaksinState();
}

class _TambahVaksinState extends State<TambahVaksin> {
  final _formKey = GlobalKey<FormState>();
  String namaVaksin = '';
  String jumlah = '';
  double nilaiSlider = 1;
  bool nilaiCheckBox = false;
  bool nilaiSwitch = true;

  Future<String> postData(CookieRequest request) async {
    request.isBiodata = true;
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/tambah_vaksin/flutter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'namaVaksin': namaVaksin,
          'jumlah': jumlah
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData["msg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text("Tambah Vaksin"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "contoh: Sinovac",
                      labelText: "Nama Vaksin",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Jumlah",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Jumlah tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}