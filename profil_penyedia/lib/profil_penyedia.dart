library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'form_profil_penyedia.dart';

class ProfilPenyedia extends StatefulWidget {
  const ProfilPenyedia({Key? key}) : super(key: key);
  @override
  ProfilPenyediaState createState() => ProfilPenyediaState();
}

class ProfilPenyediaState extends State<ProfilPenyedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                "PROFIL PENYEDIA",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                "Nama Instansi",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                "RS Rumsrak",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                "Kota",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                "Bekasi",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                "Nomor Telepon",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                "14045",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                "Alamat",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 20),
              child: Text(
                "Jatiasih",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text("Ubah Data"),
                  onPressed: () async {
                    // String notification = await postFormCatatanPenyediaValue();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormProfilPenyedia()),
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
                  child: Text("Lihat Catatan"),
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
                  child: Text("Lihat Pendaftar"),
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
          ],
        ),
      ),
    );
  }
}
