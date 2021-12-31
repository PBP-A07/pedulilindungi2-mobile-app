library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';

class LihatPendaftar extends StatefulWidget {
  const LihatPendaftar({Key? key}) : super(key: key);
  @override
  LihatPendaftarState createState() => LihatPendaftarState();
}

Future<List<dynamic>> fetchPendaftar(CookieRequest request) async {
  final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/profil-penyedia/lihat-pendaftar-json"),
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

class LihatPendaftarState extends State<LihatPendaftar> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    late Future<List<dynamic>> pendaftarData = fetchPendaftar(request);
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
                    child: Text("PENDAFTAR VAKSINASI",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ),
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
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: FutureBuilder<List<dynamic>>(
                    future: pendaftarData,
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
                                          snapshot.data![index]['nama']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                          snapshot.data![index]['nik']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                          snapshot.data![index]
                                                  ['nomor_handphone']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                          snapshot.data![index]['jenis_vaksin']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                          snapshot.data![index]['tanggal']
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
                              child: Text("Belum ada pendaftar",
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
