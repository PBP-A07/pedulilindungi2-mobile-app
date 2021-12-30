import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import 'package:pedulilindungi2_mobile_app/screens/after_login.dart';
import '../edit_profil.dart';
import '../profil_penerima.dart';

class MainTiketVaksin extends StatefulWidget {
  const MainTiketVaksin({Key? key}) : super(key: key);
  @override
  TiketVaksin createState() => TiketVaksin();
}

Future<String> postData(CookieRequest request) async {
    request.isBiodata = true;
    String usn = request.username;
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/profil-penerima/vaccine/flutter/delete/" + usn),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': request.username
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData["msg"];
  }

class TiketVaksin extends State<MainTiketVaksin> {

  Future<Map<String, dynamic>> fetchData(CookieRequest request) async {
    
    String usn = request.username;
    String url = 'http://10.0.2.2:8000/profil-penerima/vaccine/flutter/get/' + usn;
 
    try {
      Map<String, dynamic> extractedData = {};
 
      final response = await http.get(Uri.parse(url));
      extractedData['profile'] = jsonDecode(response.body);
      extractedData['request'] = request;
 
      return extractedData;
    }
 
    catch (error) {
      // print(error);
      return {"Error" : "Sorry"};
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return MaterialApp(
      title: 'Profil Penerima',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.bold
            ),
            bodyText2: const TextStyle(
              fontSize: 16, 
            ),
            headline6: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tiket Vaksin'),
        ),
        body: ListView(

          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            
            Text('TIKET VAKSIN', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 12),

            const SizedBox(height: 12),

            FutureBuilder(
              future: fetchData(request),
              builder: (context, snapshot) {
                if (snapshot.hasError) {}
                // print(snapshot.error);
                return snapshot.hasData
                  ? ItemList(
                    list: snapshot.data as Map,
                  )
                  : const Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class ItemList extends StatelessWidget {
  
  final Map list;
  const ItemList({Key? key, required this.list}) : super(key: key);
 
  @override
  Widget build(BuildContext context, ) {
    if(list['profile'].length != 1) {

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child:ListView(
          children: <Widget> [
            ListTile(
              title: const Text("Nama Penerima"),
              subtitle: Text(list['profile'][0]['fields']['namaLengkap']),
            ),
            ListTile(
              title: const Text("NIK Penerima"),
              subtitle: Text(list['profile'][0]['fields']['NIK']),
            ),
            ListTile(
              title: const Text("Tempat Vaksinasi"),
              subtitle: Text(list['profile'][1]['fields']['tempat'] + ", " + list['profile'][1]['fields']['kota']),
            ),
            ListTile(
              title: const Text("Tanggal Vaksinasi"),
              subtitle: Text(list['profile'][1]['fields']['tanggal']),
            ),
            ListTile(
              title: const Text("Jenis Vaksin"),
              subtitle: Text(list['profile'][1]['fields']['jenis_vaksin']),
            ),
            const ListTile(
              subtitle: Text('Jika anda ingin mengganti jadwal vaksin, silakan hapus tiket ini dan buat tiket baru.'),
            ),

            const SizedBox(height: 12),
              ElevatedButton.icon(
                  icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 16,
                        ),
                  label: const Text("Kembali", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MainProfilePenerima()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
              ),

              const SizedBox(height: 12),
              ElevatedButton.icon(
                  icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 16,
                        ),
                  label: const Text("Hapus Tiket Vaksin", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  onPressed: () {

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: const Text(
                              'REMINDER',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              'Apakah anda yakin ingin menghapus tiket vaksin?',
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
                                                    BorderRadius.circular(20)),
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
                                                fontWeight: FontWeight.bold),
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
                                        String message =
                                            await postData(list['request']);

                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                    backgroundColor:
                                                        const Color(0xEA068F1C),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    content:
                                                        Row(children: <Widget>[
                                                      // ignore: prefer_const_constructors
                                                      Expanded(
                                                          flex: 1,
                                                          child: const Icon(
                                                            Icons
                                                                .check_circle_outline_rounded,
                                                            color: Colors.white,
                                                            size: 35,
                                                          )),

                                                      Expanded(
                                                        flex: 9,
                                                        child: Text(
                                                          message,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ]),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 20),
                                                            child: SizedBox(
                                                                height: 40,
                                                                child: SizedBox(
                                                                  height: 40,
                                                                  child:
                                                                      TextButton(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                    onPressed: () => {
                                                                        Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  const MainProfilePenerima()),
                                                                        )
                                                                      },
                                                                    
                                                                    child:
                                                                        const Text(
                                                                      'OK',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xffffffff),
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                )),
                                                          )
                                                        ],
                                                      )
                                                    ]));
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
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
              ), 
          ]
        )
      );
    }

    else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        child:ListView(
          children: <Widget> [
            const ListTile(
              title: Text("Anda belum mendaftarkan diri untuk ikut vaksinasi"),
              subtitle: Text("Silakan daftarkan diri anda terlebih dahulu"),
            ),

            const SizedBox(height: 12),
              ElevatedButton.icon(
                  icon: const Icon(
                          Icons.health_and_safety_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                  label: const Text("Daftar Vaksinasi", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const MainProfilePenerima()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
              ),

            const SizedBox(height: 12),
              ElevatedButton.icon(
                  icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 16,
                        ),
                  label: const Text("Kembali", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MainProfilePenerima()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
              ),
          ]
        )
      );
    }


  }
}