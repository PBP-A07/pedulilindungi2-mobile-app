library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormProfilPenyedia extends StatefulWidget {
  const FormProfilPenyedia({Key? key}) : super(key: key);
  @override
  FormProfilPenyediaState createState() {
    return FormProfilPenyediaState();
  }
}

class FormProfilPenyediaState extends State<FormProfilPenyedia> {
  final _formKey = GlobalKey<FormState>();
  String namaInstansi = "";
  String kota = "";
  String nomorTelepon = "";
  String alamat = "";
  final myController = TextEditingController();

  Future<dynamic> fetchPenyedia() async {
    final response = await http.get(Uri.parse(
        "http://127.0.0.1:8000/profil-penyedia/profil-penyedia-json"));
    if (response.statusCode == 200) {
      dynamic penyedia = jsonDecode(response.body);
      namaInstansi = penyedia['fields']['namaInstansi'];
      kota = penyedia['fields']['kota'];
      nomorTelepon = penyedia['fields']['nomorTelepon'];
      alamat = penyedia['fields']['alamat'];
    } else {
      throw Exception("Failed to load Penyedia info");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchPenyedia();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "UBAH PROFIL PENYEDIA",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: namaInstansi,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Tuliskan nama instansi di sini',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    labelText: 'Nama Instansi',
                    labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                onChanged: (String? val) {
                  setState(() {
                    namaInstansi = val!;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tolong tuliskan nama instansi di sini';
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: kota,
                decoration: const InputDecoration(
                    icon: Icon(Icons.location_city),
                    hintText: 'Tuliskan kota instansi di sini',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    labelText: 'Kota',
                    labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                onChanged: (String? val) {
                  setState(() {
                    kota = val!;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tolong tuliskan kota instansi di sini';
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: nomorTelepon,
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: 'Tuliskan nomor telepon instansi di sini',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    labelText: 'Nomor Telepon',
                    labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                onChanged: (String? val) {
                  setState(() {
                    nomorTelepon = val!;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tolong tuliskan nomor telepon instansi di sini';
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: alamat,
                decoration: const InputDecoration(
                    icon: Icon(Icons.location_pin),
                    hintText: 'Tuliskan alamat instansi di sini',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    labelText: 'Alamat',
                    labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                onChanged: (String? val) {
                  setState(() {
                    alamat = val!;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tolong tuliskan alamat instansi di sini';
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text("Ubah"),
                  onPressed: () async {
                    // String notification = await postFormCatatanPenyediaValue();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => new AlertDialog(
                        content: new Text("notification"),
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
        ),
      ),
    );
  }
}
