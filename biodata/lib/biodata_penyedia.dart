// ignore_for_file: avoid_print

library biodata;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import 'package:pedulilindungi2_mobile_app/screens/after_login_penyedia.dart';

class BiodataPenyedia extends StatefulWidget {
  const BiodataPenyedia({Key? key}) : super(key: key);
  @override
  BiodataPenyediaState createState() {
    return BiodataPenyediaState();
  }
}

class BiodataPenyediaState extends State<BiodataPenyedia> {
  final _formKey = GlobalKey<FormState>();
  String namaInstansi = '';
  String kota = '';
  String nomorTelepon = '';
  String alamat = '';
  final myController = TextEditingController();

  void printHasil() {
    print("Nama Instansi: " + namaInstansi);
    print("Kota: " + kota);
    print("Nomor Telepon: " + nomorTelepon);
    print("Alamat: " + alamat);
  }

  Future<String> postData(CookieRequest request) async {
    request.isBiodata = true;
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/biodata/penyedia/flutter"),
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
    return extractedData["msg"];
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body:  Form(
      key: _formKey,
      child: ListView(
        // padding: const EdgeInsets.only(left: 25, right: 35),
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 15),
            child: const Text('INFORMASI PENYEDIA',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
                decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    icon: Icon(Icons.corporate_fare_rounded),
                    hintText: 'Masukkan nama instansi kamu',
                    labelText: 'Nama Instansi',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                onChanged: (String? value) {
                  setState(() {
                    namaInstansi = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                    // sources https://stackoverflow.com/questions/43935255/regular-expression-for-name-with-spaces-allowed-in-between-the-text-and-avoid-sp
                  } else if (!value
                      .toString()
                      .contains(RegExp(r'^(?![\s.]+$)[a-zA-Z\s.]*$'))) {
                    return "Tolong masukkan nama instansi yang benar!";
                  }
                  return null;
                }),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    icon: Icon(Icons.location_city_outlined),
                    hintText: 'Masukkan kota instansi kamu',
                    labelText: 'Kota',
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                maxLength: 16,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                onChanged: (String? value) {
                  setState(() {
                    kota = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  } else if (!value
                      .toString()
                      .contains(RegExp(r'^(?![\s.]+$)[a-zA-Z\s.]*$'))) {
                    return "Tolong masukkan kota instansi yang benar!";
                  }
                  return null;
                }),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    icon: Icon(Icons.phone),
                    hintText: 'Masukkan nomor telepon instansi kamu',
                    labelText: 'Nomor telepon',
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                maxLength: 10,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                onChanged: (String? value) {
                  setState(() {
                    nomorTelepon = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  } else if (value.toString().length != 10 ) {
                    return "Nomor telepon instansi tidak valid!";
                  }
                  return null;
                }),
          ),
          
          Container(
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
                decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    icon: Icon(Icons.location_on_outlined),
                    hintText: 'Masukkan alamat instansi kamu',
                    labelText: 'Alamat',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                onChanged: (String? value) {
                  setState(() {
                    alamat = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                    // sources https://stackoverflow.com/questions/43935255/regular-expression-for-name-with-spaces-allowed-in-between-the-text-and-avoid-sp
                  } else if (!value
                      .toString()
                      .contains(RegExp(r'^(?![\s.]+$)[a-zA-Z0-9\s.]{5,}$'))) {
                    return "Alamat instansi tidak valid!";
                  }
                  return null;
                }),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 140, vertical: 20),
              child: SizedBox(
                height: 45,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: const Color(0xFF4A1FFF),
                    // maximumSize: MaterialStateProperty.all(const Size(50, 40)),
                  ),
                  onPressed: () {
                    printHasil();
                    if (_formKey.currentState!.validate()) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );

                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: const Text(
                            'REMINDER',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Have you filled out the form correctly?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child: SizedBox(
                                    height: 45,
                                    child: SizedBox(
                                      height: 45,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                          backgroundColor:
                                              const Color(0xFFFF0000),
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context, 'No'),
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 18,
                                              fontWeight:
                                                  FontWeight.bold),
                                        ),
                                      ),
                                    ))),
                            Container(
                                margin: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child: SizedBox(
                                  height: 45,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          const Color(0xEA068F1C),
                                    ),
                                    // sources https://docs.flutter.dev/cookbook/navigation/navigation-basics
                                    onPressed: () async {
                                      String message = await postData(request);
                                      
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          backgroundColor: const Color(0xEA068F1C),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)),
                                          content: Row(
                                            children: <Widget> [
                                              // ignore: prefer_const_constructors
                                              Expanded(
                                                flex: 1,
                                                child: const Icon(
                                                  Icons.check_circle_outline_rounded,
                                                  color: Colors.white,
                                                  size: 35,
                                                )
                                              ),
                                              
                                              Expanded(
                                                flex: 9,
                                                child: Text(
                                                  message,
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                              
                                            ]),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 20),
                                                  child: SizedBox(
                                                  height: 40,
                                                  child: SizedBox(
                                                      height: 40,
                                                      child: TextButton(
                                                        style: TextButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(20)
                                                          ),
                                                          backgroundColor: Colors.black,
                                                        ),
                                                        onPressed: () => {
                                                          Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyHomePagePenyedia()),
                                                          )
                                                        },
                                                        // TODO : arahin ke halaman HOME 
                                                        child: const Text(
                                                          'OK',
                                                          style: TextStyle(
                                                              color: Color(0xffffffff),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                      ),
                                                    )
                                                  ),
                                                )
                                              ],
                                            )
                                          ]
                                        )
                                      );

                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('SUBMIT',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ))
          ],
        ),
      ),
    );
  }
}