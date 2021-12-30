library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';

import 'lihat_catatan_penyedia.dart';

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

  Future<String> postFormCatatanPenyediaValue(CookieRequest request) async {
    final response = await http.post(
        Uri.parse(
            "http://127.0.0.1:8000/profil-penyedia/catatan-penyedia-flutter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'message': message,
          'username': request.username
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData['notification'];
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Title(color: Colors.blueAccent, child: Text("PeduliLindungi2.0")),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "TAMBAH CATATAN PENYEDIA",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
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
                      return 'Harap isi judul catatan';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
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
                      return 'Harap isi pesan catatan';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_rounded),
                    label: const Text("Tambah"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String notification =
                            await postFormCatatanPenyediaValue(request);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LihatCatatanPenyedia()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fixedSize: const Size(200, 40),
                      primary: Colors.blueAccent,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.keyboard_return_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text("Kembali"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fixedSize: const Size(200, 40),
                      primary: Colors.redAccent),
                ),
              )
            ],
          )),
    );
  }
}
