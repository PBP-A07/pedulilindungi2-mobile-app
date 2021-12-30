library profil_penyedia;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';

import 'profil_penyedia.dart';

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

  Future<Map<String, dynamic>> fetchProfilPenyedia(
      CookieRequest request) async {
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

  Future<String> postUpdateProfilPenyediaValue(CookieRequest request) async {
    final response = await http.post(
        Uri.parse(
            "http://127.0.0.1:8000/profil-penyedia/profil-penyedia-flutter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'namaInstansi': namaInstansi,
          'kota': kota,
          'nomorTelepon': nomorTelepon,
          'alamat': alamat,
          'username': request.username
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData['notification'];
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    late Future<Map<String, dynamic>> profilPenyediaData =
        fetchProfilPenyedia(request);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              Title(color: Colors.blueAccent, child: Text("PeduliLindungi2.0")),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: profilPenyediaData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "UBAH PROFIL PENYEDIA",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        initialValue:
                            snapshot.data!['fields']['namaInstansi'].toString(),
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            icon: Icon(Icons.corporate_fare_rounded),
                            hintText: 'Tuliskan nama instansi di sini',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            labelText: 'Nama Instansi',
                            labelStyle: TextStyle(fontSize: 15)),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        onChanged: (String? val) {
                          setState(() {
                            namaInstansi = val!;
                          });
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
                        maxLength: 16,
                        initialValue:
                            snapshot.data!['fields']['kota'].toString(),
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            icon: Icon(Icons.location_city_rounded),
                            hintText: 'Tuliskan kota instansi di sini',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            labelText: 'Kota',
                            labelStyle: TextStyle(fontSize: 15),
                            counterText: ""),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        onChanged: (String? val) {
                          setState(() {
                            kota = val!;
                          });
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 10,
                        initialValue:
                            snapshot.data!['fields']['nomorTelepon'].toString(),
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            icon: Icon(Icons.phone),
                            hintText: 'Tuliskan nomor telepon instansi di sini',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            labelText: 'Nomor Telepon',
                            labelStyle: TextStyle(fontSize: 15),
                            counterText: ""),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        onChanged: (String? val) {
                          setState(() {
                            nomorTelepon = val!;
                          });
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
                        initialValue:
                            snapshot.data!['fields']['alamat'].toString(),
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            icon: Icon(Icons.location_pin),
                            hintText: 'Tuliskan alamat instansi di sini',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            labelText: 'Alamat',
                            labelStyle: TextStyle(fontSize: 15)),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        onChanged: (String? val) {
                          setState(() {
                            alamat = val!;
                          });
                        },
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.edit_rounded),
                          label: const Text("Ubah"),
                          onPressed: () async {
                            if (namaInstansi.isEmpty) {
                              namaInstansi = snapshot.data!['fields']
                                      ['namaInstansi']
                                  .toString();
                            }
                            if (kota.isEmpty) {
                              kota =
                                  snapshot.data!['fields']['kota'].toString();
                            }
                            if (nomorTelepon.isEmpty) {
                              nomorTelepon = snapshot.data!['fields']
                                      ['nomorTelepon']
                                  .toString();
                            }
                            if (alamat.isEmpty) {
                              alamat =
                                  snapshot.data!['fields']['alamat'].toString();
                            }
                            String notification =
                                await postUpdateProfilPenyediaValue(request);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilPenyedia()),
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
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text('${snapshot.error}')],
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
