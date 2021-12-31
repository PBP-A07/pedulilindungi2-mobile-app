import 'package:daftar_vaksin/daftar_vaksin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './details.dart';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import 'package:profil_penerima/profil_penerima.dart';
 
class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title, IconData icon, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.lightBlue,
            child: TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>const MainProfilePenerima()),);}, 
            child: const Text(
              'Profil',
              style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.white),
            ),
            )
            
          ),
 
          const SizedBox(height: 20),
 
          buildListTile('Daftar Vaksin', Icons.coronavirus, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarVaksin()));
          }),
         
          buildListTile('Log Out', Icons.logout, () {
            //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
 
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
 
  Future<String> postData(CookieRequest request) async {
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/post-question-flutter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': judul,
          'body' : pertanyaan,
          'username' : request.username,
        }));
 
    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData["msg"];
  }
 
  Future<Map<String, dynamic>> fetchData() async {
    const url = 'http://127.0.0.1:8000/json-flutter';
    const url2 = 'http://127.0.0.1:8000/json-account';
 
    try {
      Map<String, dynamic> extractedData = {};
 
      final response = await http.get(Uri.parse(url));
      extractedData['forums'] = jsonDecode(response.body);
 
      final response2 = await http.get(Uri.parse(url2));
      extractedData['accounts'] = jsonDecode(response2.body);
 
      return extractedData;
    }
 
    catch (error) {
      // print(error);
      return {"Error" : "Sorry"};
    }
  }
 
  final _formKey = GlobalKey<FormState>();
  var pertanyaan = "";
  var judul = "";
 
  bool validate() {
    bool status = false;
    final form = _formKey.currentState;
    form?.save();
   
    if (form!.validate()) {
      form.save();
      status = true;
    } else {
      status = false;
    }
   
    return status;
  }
 
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(),
      drawer: const MainDrawer(),
      backgroundColor: Colors.lightBlue,
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 40.0),
 
          // WELCOME PAGE
          Padding (
            padding: const EdgeInsets.only(left: 30.0),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget> [
                Text("Selamat datang di",
                  style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  )
                ),
                Text("PeduliLindungi2.0",
                  style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  )
                ),
              ]
            )
          ),
 
          const SizedBox(height:40.0),
     
          Container(
            height: MediaQuery.of(context).size.height - 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: const EdgeInsets.only(left:40.0, right:25.0),
              children: <Widget>[
                const SizedBox(height:50.0),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    const Text("Forum",
                      style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      )
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed:() {},
                      color: Colors.lightBlue,
                    ),
                  ]
                ),
 
                // FORUM PAGE
                Padding (
                  padding: const  EdgeInsets.only(top: .0),
                  child:  SizedBox(
                    height: MediaQuery.of(context).size.height - 250.0,
                    child: SizedBox (
                      child: ListView(
                        children: [
                          Form(
                            key: _formKey,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
 
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Masukkan judul forum",
                                      labelText: "Judul Forum",
                                      icon: const Icon(Icons.question_answer_outlined),
                                      border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Judul tidak boleh kosong';
                                      }
                                      judul = value;
                                      return null;
                                    },
                                  ),
 
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Masukkan pertanyaan Anda",
                                      labelText: "Pertanyaan",
                                    ),
 
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Pertanyaan tidak boleh kosong';
                                      }
                                      pertanyaan = value;
                                      return null;
                                    },
                                  ),
 
                                  const SizedBox(height:25.0),
                                 
                                  ElevatedButton(
                                    child: Ink(
                                      decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        // gradient:  LinearGradient(
                                        //   // colors: <Color>[Colors.blue.shade600, Colors.deepPurple.shade300,],
                                        //   begin: Alignment.topLeft,
                                        //   end: Alignment.bottomRight,
                                        // ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                                      child: const Text("Kirim", style: TextStyle(
                                        color: Colors.white,
                                      )),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        postData(request);
                                
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage()),
                                        );
                                                                     
                                      }
 
                       
                                    },
                                  ),
 
 
                                ],
                              ),
                            ),
                          ),
 
                          const SizedBox(height:30.0),
 
                          FutureBuilder(
                            future: fetchData(),
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
                          )
                        ]
                      )  
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}
 
 
 
class ItemList extends StatelessWidget {
  final Map list;
 
  const ItemList({Key? key, required this.list}) : super(key: key);
 
  String getAuthor(pk) {
    for (var auth in list['accounts']) {
      if (auth["pk"] == pk) {
        return auth['fields']['username'];
      }
    }
    return "Anonimus";
  }
 
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 300,
      child:ListView.builder(
        itemCount: list['forums'].length,
        itemBuilder: (context, i) {
 
          String a = getAuthor(list['forums'][i]['fields']['author']);
          String time = list['forums'][i]['fields']['created_at'];
         
          return Container(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context)=> Detail(index: i, list: list['forums'])
                    )
                  ),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Row(
                        children: <Widget> [
                          Column(
                            children: const [
                              Icon(Icons.message),
                            ],
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10,),
                              Text(list['forums'][i]['fields']['title'],
                                style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                )
                              ),
                              Text("dibuat oleh " +a+" pada "+time.substring(0, 10),
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 11.0,
                                  )
                              ),
                              Text("pukul ${time.substring(11, 19)}",
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 11.0,
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height:10),
                      Text(list['forums'][i]['fields']['body']),
                    ]
                  )
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
 
 
 
 
 
 

