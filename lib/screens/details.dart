 
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'after_login.dart';
import 'dart:convert';
 
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({required this.index, required this.list});
  @override
  _DetailState createState() => new _DetailState();
}
 
class _DetailState extends State<Detail> {
 
Future<Map<String, dynamic>> fetchData() async {
  String url = 'http://127.0.0.1:8000/question/${widget.list[widget.index]['pk']}/json';
  const url2 = 'http://127.0.0.1:8000/json-account';
 
  try {
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> extractedData = new Map();
    extractedData['forums'] = jsonDecode(response.body);
   
    final response2 = await http.get(Uri.parse(url2));
    extractedData['accounts'] = jsonDecode(response2.body);
   
    return extractedData;
  }
  // try {
  //  final response = await http.get(Uri.parse(url));
  //  List<dynamic> extractedData = jsonDecode(response.body);
  //  print(extractedData);
  //  return extractedData;
  // }
 
  catch (error) {
    print(error);
    return {"error" : "sorry"};
  }
 
  }
 
 
 
  @override
  Widget build(BuildContext context) {
  fetchData();
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['fields']['title']}")),
      body: new Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height - 100,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                SizedBox(height: 20,),
                new Text("${widget.list[widget.index]['fields']['body']}", style: new TextStyle(fontSize: 18.0),),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(onPressed: (){print("YEYY");}, child: Text("Balas")),
                  ],
                 
 
 
                ),
 
                new FutureBuilder(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
 
                            return snapshot.hasData
                            ? new ItemList(
                              list: snapshot.data as Map,
                              parentID: widget.list[widget.index]['pk'],
                            )
                            : new Center(
                              child: new CircularProgressIndicator(),
                            );
                          },
                        )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 
class ItemList extends StatefulWidget {
  final Map list;
  final int parentID;
 
  ItemList( {
    required this.list,
    required this.parentID
    }
  );
 
  @override
  State<ItemList> createState() => _ItemState(list: this.list, parentID: this.parentID);
}
 
class _ItemState extends State<ItemList> {
  final Map list;
  final int parentID;
 
  _ItemState ( {
    required this.list,
    required this.parentID
    }
  );
 
  String getAuthor(pk) {
    for (var auth in list['accounts']) {
      if (auth["pk"] == pk) {
        return auth['fields']['username'];
      }
    }
    return "";
  }
 
  Future<Map<String, dynamic>> fetchData(i) async {
  String url = 'http://127.0.0.1:8000/question/${parentID}/discussion/${i}/json';
  const url2 = 'http://127.0.0.1:8000/json-account';
 
  try {
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> extractedData = new Map();
    extractedData['forums'] = jsonDecode(response.body);
   
    final response2 = await http.get(Uri.parse(url2));
    extractedData['accounts'] = jsonDecode(response2.body);
    print(extractedData);
   
    return extractedData;
  }
  // try {
  //  final response = await http.get(Uri.parse(url));
  //  List<dynamic> extractedData = jsonDecode(response.body);
  //  print(extractedData);
  //  return extractedData;
  // }
 
  catch (error) {
    print(error);
    return {"error" : "sorry"};
  }
 
  }
 
  // Future<Map<dynamic, dynamic>> _replies = Future(foo);
           
  // List<dynamic> accountList = [];
   
 
 
  @override
  Widget build(BuildContext context) {
  //  print(list);
  //  print(list.length);
   
   
 
    return Container(
      height: 300,
      child:ListView.builder(
      itemCount: list == null ? 0 : list['forums'].length,
      itemBuilder: (context, i) {
        // print(list['forums'][i]['fields']['author']);
        // print(getAuthor(list['forums'][i]['fields']['author']));
        // print(list);
         
          // print("\n");
          print("\n");
       
        print(i);
          // fetchData(list['forums'][i]['pk']).then((val) => setState(() {
          // // //   print("=========================");
          // // //   print(val);
          //       _replies = val;
          //     }));
         
          // Map _replies = {"" : ""};
          Future _replies = fetchData(list['forums'][i]['pk']);
 
          // fetchData(list['forums'][i]['pk']);
         
          //     _replies = value;
          // });
            // print(list);
 
          // // print("\n");
          // // print("\n");
          // // print("\n");
          // print("\n");
       
        print('http://127.0.0.1:8000/question/${parentID}/discussion/${list['forums'][i]['pk']}/json');
 
        // _replies = jsonDecode(http.get(Uri.parse('http://127.0.0.1:8000/question/${parentID}/discussion/${list['forums'][i]['pk']}/json')));
 
 
        print(_replies);
 
        String a = getAuthor(list['forums'][i]['fields']['author']);
        String time = list['forums'][i]['fields']['created_at'];
        // print(a);
        // print(time);
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new Text('data')
              )
            ),
           
            child: new Column(
              children: <Widget>[
                new Text('${list['forums'][i]['fields']['body']}'),
                new Text('dibuat oleh ${a} pada ${time.substring(0, 10)} pukul ${time.substring(11, 19)}'),
 
              ],
 
              // children: new ListTile(
              //   title: new Text(list['forums'][i]['fields']['body']),
              //   leading: new Icon(Icons.message),
              //   subtitle: new Text("dibuat oleh ${a} pada ${time.substring(0, 10)} pukul ${time.substring(11, 19)}"),
              // ),
            ),
          ),
        );
      },
    )
    );
  }
}

