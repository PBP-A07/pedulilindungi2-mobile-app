library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import 'package:pedulilindungi2_mobile_app/screens/after_login_penyedia.dart';

import 'lihat_catatan_penyedia.dart';
import 'lihat_pendaftar.dart';
import 'form_profil_penyedia.dart';

class ProfilPenyedia extends StatefulWidget {
  const ProfilPenyedia({Key? key}) : super(key: key);
  @override
  ProfilPenyediaState createState() => ProfilPenyediaState();
}

Future<Map<String, dynamic>> fetchProfilPenyedia(CookieRequest request) async {
  final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/profil-penyedia/profil-penyedia-json"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': request.username}));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body)[0];
    return data;
  } else {
    throw Exception("Failed to load response");
  }
}

class ProfilPenyediaState extends State<ProfilPenyedia> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    late Future<Map<String, dynamic>> profilPenyediaData =
        fetchProfilPenyedia(request);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Title(
            color: Colors.blueAccent, child: const Text("PeduliLindungi2.0")),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: profilPenyediaData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text(
                        "PROFIL PENYEDIA",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: const Text(
                        "Nama Instansi",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        snapshot.data!['fields']['namaInstansi'].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: const Text(
                        "Kota",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        snapshot.data!['fields']['kota'].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: const Text(
                        "Nomor Telepon",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        snapshot.data!['fields']['nomorTelepon'].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: const Text(
                        "Alamat",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 20),
                      child: Text(
                        snapshot.data!['fields']['alamat'].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.edit_rounded),
                          label: const Text("Ubah Data"),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FormProfilPenyedia()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: const Size(200, 40),
                            primary: Colors.blueAccent,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.note_rounded),
                          label: const Text("Lihat Catatan"),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LihatCatatanPenyedia()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: const Size(200, 40),
                            primary: Colors.blueAccent,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.people_rounded),
                          label: const Text("Lihat Pendaftar"),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LihatPendaftar()),
                            );
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
                        icon: const Icon(Icons.home_rounded),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyHomePagePenyedia()),
                          );
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
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text('${snapshot.error}')],
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
