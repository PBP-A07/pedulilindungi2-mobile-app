library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';

import 'profil_penyedia.dart';
import 'form_catatan_penyedia.dart';

class LihatCatatanPenyedia extends StatefulWidget {
  const LihatCatatanPenyedia({Key? key}) : super(key: key);
  @override
  LihatCatatanPenyediaState createState() => LihatCatatanPenyediaState();
}

Future<List<dynamic>> fetchCatatanPenyedia(CookieRequest request) async {
  final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/profil-penyedia/catatan-penyedia-json"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': request.username}));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception("Failed to load response");
  }
}

class LihatCatatanPenyediaState extends State<LihatCatatanPenyedia> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    late Future<List<dynamic>> catatanPenyediaData =
        fetchCatatanPenyedia(request);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Title(
            color: Colors.blueAccent, child: const Text("PeduliLindungi2.0")),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Center(
                    child: Text("CATATAN PENYEDIA",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_rounded),
                      label: const Text("Tambah Catatan"),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FormCatatanPenyedia()),
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
                    icon: const Icon(Icons.keyboard_return_rounded),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilPenyedia()),
                      );
                    },
                    label: const Text("Kembali"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: const Size(200, 40),
                        primary: Colors.redAccent),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: FutureBuilder<List<dynamic>>(
                    future: catatanPenyediaData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                          snapshot.data![index]['fields']
                                                  ['title']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                          snapshot.data![index]['fields']
                                                  ['message']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF89E5FF),
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            },
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            child: const Center(
                              child: Text("Belum ada catatan",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Column(
                          children: [Text('${snapshot.error}')],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
