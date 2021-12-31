// @dart=2.12
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:profil_penerima/tiket_vaksin.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import 'package:pedulilindungi2_mobile_app/screens/after_login.dart';
import '../edit_profil.dart';


class MainProfilePenerima extends StatefulWidget {
  const MainProfilePenerima({Key? key}) : super(key: key);
  @override
  ProfilPenerima createState() => ProfilPenerima();
}

class ProfilPenerima extends State<MainProfilePenerima> {

  Future<Map<String, dynamic>> fetchData(CookieRequest request) async {
    
    String usn = request.username;
    String url = 'http://10.0.2.2:8000/profil-penerima/user/flutter/' + usn;
 
    try {
      Map<String, dynamic> extractedData = {};
 
      final response = await http.get(Uri.parse(url));
      extractedData['profile'] = jsonDecode(response.body);
 
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
          title: const Text('Profil Pengguna'),
        ),
        body: ListView(

          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            
            Text('PROFIL PENGGUNA', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 12),

            TextButton.icon(
                icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 16,
                      ),
                label: const Text("Ubah Data", style: TextStyle(fontSize: 16),),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileForm()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
            ),

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

            const SizedBox(height: 12),
            
            ElevatedButton.icon(
                icon: const Icon(
                        Icons.credit_card,
                        color: Colors.white,
                        size: 16,
                      ),
                label: const Text("Lihat Tiket Vaksin", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MainTiketVaksin()),
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
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 16,
                      ),
                label: const Text("Kembali ke Menu Utama", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage()),
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
                        Icons.logout,
                        color: Colors.white,
                        size: 16,
                      ),
                label: const Text("Logout", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                onPressed: () {
                   // print('Console Message Using Print');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
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
    
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child:ListView(
        children: <Widget> [
          ListTile(
            title: const Text("Email"),
            subtitle: Text(list['profile'][0]['fields']['email']),
          ),
          ListTile(
            title: const Text("NIK"),
            subtitle: Text(list['profile'][1]['fields']['NIK'].toString()),
          ),
          ListTile(
            title: const Text("Nama Lengkap"),
            subtitle: Text(list['profile'][1]['fields']['namaLengkap']),
          ),
          ListTile(
            title: const Text("Tanggal Lahir"),
            subtitle: Text(list['profile'][1]['fields']['tanggalLahir'].toString()),
          ),
          ListTile(
            title: const Text("Jenis Kelamin"),
            subtitle: Text(list['profile'][1]['fields']['jenisKelamin']),
          ),
          ListTile(
            title: const Text("Nomor Telepon"),
            subtitle: Text(list['profile'][1]['fields']['nomorHandphone'].toString()),
          ),
          ListTile(
            title: const Text("Alamat"),
            subtitle: Text(list['profile'][1]['fields']['alamat']),
          ),
        ]
      )
    );
  }
}