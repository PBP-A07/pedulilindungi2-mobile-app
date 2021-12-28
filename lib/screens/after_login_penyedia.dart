import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './details.dart';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
 
class MyApp extends StatelessWidget { // stateless widget punya method yg namanya build yg harus dioverride di class turunannya
 
  @override
  Widget build(BuildContext context) { // ini yg bakal ditampilkan di layar
    return MaterialApp( // sebuah widget yg berisi data2 yg diperlukan oleh aplikasi yg menggunakan material design
      home: MyHomePagePenyedia(),
      debugShowCheckedModeBanner: false,
      title: 'PeduliLindungi2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.indigo,
        primaryColor: Colors.white,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        ),
      ),
    );
  }
}
 
class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {},
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
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.lightBlue,
            child: Text(
              'Profil',
              style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Theme.of(context).primaryColor),
            ),
          ),
 
          SizedBox(height: 20),
 
          buildListTile('Tambahkan Vaksin', Icons.coronavirus, () {
            //Navigator.of(context).pushReplacementNamed('/');
          }),
         
          buildListTile('Log Out', Icons.logout, () {
            //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
 
 
class MyHomePagePenyedia extends StatefulWidget {
  @override
  _MyHomePageStatePenyedia createState() => _MyHomePageStatePenyedia();
}
 
class _MyHomePageStatePenyedia extends State<MyHomePagePenyedia> {
 
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
      Map<String, dynamic> extractedData = new Map();
 
      final response = await http.get(Uri.parse(url));
      extractedData['forums'] = jsonDecode(response.body);
 
      final response2 = await http.get(Uri.parse(url2));
      extractedData['accounts'] = jsonDecode(response2.body);
 
      return extractedData;
    }
 
    catch (error) {
      print(error);
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
      drawer: MainDrawer(),
      backgroundColor: Colors.lightBlue,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 40.0),
 
          // WELCOME PAGE
          Padding (
            padding: EdgeInsets.only(left: 30.0),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
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
 
          SizedBox(height:40.0),
     
          Container(
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left:40.0, right:25.0),
              children: <Widget>[
                SizedBox(height:50.0),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Text("Forum",
                      style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      )
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed:() {},
                      color: Colors.lightBlue,
                    ),
                  ]
                ),
 
                // FORUM PAGE
                Padding (
                  padding: EdgeInsets.only(top: .0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 250.0,
                    child: Container(
                      child: ListView(
                        children: [
                          Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
 
                                  TextFormField(
                                    decoration: new InputDecoration(
                                      hintText: "Masukkan judul forum",
                                      labelText: "Judul Forum",
                                      icon: Icon(Icons.question_answer_outlined),
                                      border: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(5.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Judul tidak boleh kosong';
                                      }
                                      judul = "$value";
                                      return null;
                                    },
                                  ),
 
                                  TextFormField(
                                    decoration: new InputDecoration(
                                      hintText: "Masukkan pertanyaan Anda",
                                      labelText: "Pertanyaan",
                                    ),
 
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Pertanyaan tidak boleh kosong';
                                      }
                                      pertanyaan = "$value";
                                      return null;
                                    },
                                  ),
 
                                  SizedBox(height:25.0),
                                 
                                  RaisedButton(
                                    child: Text(
                                      "Kirim",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        print("Pertanyaan telah terkirim");
                                        print("Berikut merupakan forum baru yang Anda buat: ");
                                        print("Judul Forum : $judul");
                                        print("Pertanyaan  : $pertanyaan");
                                        postData(request);
                                
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePagePenyedia()),
                                        );
                                                                     
                                      }
 
                       
                                    },
                                  ),
 
                                ],
                              ),
                            ),
                          ),
 
                          SizedBox(height:30.0),
 
                          new FutureBuilder(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                ? new ItemList(
                                  list: snapshot.data as Map,
                                )
                                : new Center(
                                  child: new CircularProgressIndicator(),
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
 
  ItemList ({
    required this.list,
  });
 
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
    
    return Container(
      height: 300,
      child:ListView.builder(
        itemCount: list == null ? 0 : list['forums'].length,
        itemBuilder: (context, i) {
 
          String a = getAuthor(list['forums'][i]['fields']['author']);
          String time = list['forums'][i]['fields']['created_at'];
         
          return new Container(
            padding: const EdgeInsets.all(2.0),
            child: new Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context)=> new Detail(index: i, list: list['forums'])
                    )
                  ),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Row(
                        children: <Widget> [
                          Column(
                            children: [
                              Icon(Icons.message),
                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Text(list['forums'][i]['fields']['title'],
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                )
                              ),
                              Text("dibuat oleh ${a} pada ${time.substring(0, 10)}",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 11.0,
                                  )
                              ),
                              Text("pukul ${time.substring(11, 19)}",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 11.0,
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height:10),
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
 
 
 
 
 
 

