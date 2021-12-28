library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormCatatanPenyedia extends StatefulWidget {
  const FormCatatanPenyedia({Key? key}) : super(key: key);
  @override
  FormCatatanPenyediaState createState() {
    return FormCatatanPenyediaState();
  }
}

class FormCatatanPenyediaState extends State<FormCatatanPenyedia> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String message = "";
  final myController = TextEditingController();

  Future<String> postFormCatatanPenyediaValue() async {
    final response = await http.post(
        Uri.parse(
            "http://127.0.0.1:8000/profil-penyedia/catatan-penyedia-flutter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'message': message,
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData['notification'];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              "TAMBAH CATATAN PENYEDIA",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_fields),
                    hintText: 'Tuliskan judul catatan di sini',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    labelText: 'Judul Catatan',
                    labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                onChanged: (String? val) {
                  setState(() {
                    title = val!;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tolong tuliskan judul Anda di sini';
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.notes),
                    hintText: 'Tuliskan pesan catatan di sini',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    labelText: 'Pesan Catatan',
                    labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                minLines: 5,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (String? val) {
                  setState(() {
                    message = val!;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tolong tuliskan pesan Anda di sini';
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text("Tambah"),
                  onPressed: () async {
                    String notification = await postFormCatatanPenyediaValue();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => new AlertDialog(
                        content: new Text(notification),
                        actions: <Widget>[
                          new IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: new Icon(Icons.close))
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 35),
                    primary: Colors.blueAccent,
                  ),
                )),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Kembali"),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 35), primary: Colors.redAccent),
              ),
            )
          ],
        ));
  }
}
