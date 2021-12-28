import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
class Detail extends StatefulWidget {
  final List list;
  final int index;
  const Detail({Key? key, required this.index, required this.list}) : super(key: key);
  // Detail({});
  @override
  _DetailState createState() => _DetailState();
}
 
class _DetailState extends State<Detail> {
 
Future<Map<String, dynamic>> fetchData() async {
  String url = 'http://127.0.0.1:8000/question/${widget.list[widget.index]['pk']}/json';
  const url2 = 'http://127.0.0.1:8000/json-account';
 
  try {
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> extractedData = {};
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
    // print(error);
    return {"error" : "sorry"};
  }
 
  }
 
 
 
  @override
  Widget build(BuildContext context) {
  fetchData();
    return  Scaffold(
      appBar: AppBar(title: Text("${widget.list[widget.index]['fields']['title']}")),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height - 100,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                Text("${widget.list[widget.index]['fields']['body']}", style: const TextStyle(fontSize: 18.0),),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(onPressed: (){
                      // print("YEYY");
                      }, child: const Text("Balas")),
                  ],
                 
 
 
                ),
 
                FutureBuilder(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError){}
                              // print(snapshot.error);
 
                            return snapshot.hasData
                            ? ItemList(
                              list: snapshot.data as Map,
                              parentID: widget.list[widget.index]['pk'],
                            )
                            : const Center(
                              child: CircularProgressIndicator(),
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
 
  const ItemList( {
    required this.list,
    required this.parentID,
    Key? key}) : super(key: key
  );
 
  @override
  State<ItemList> createState() => _ItemState(list:list, parentID:parentID);
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
  String url = 'http://127.0.0.1:8000/question/' + parentID.toString() + '/discussion/' + i + '/json';
  const url2 = 'http://127.0.0.1:8000/json-account';
 
  try {
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> extractedData = {};
    extractedData['forums'] = jsonDecode(response.body);
   
    final response2 = await http.get(Uri.parse(url2));
    extractedData['accounts'] = jsonDecode(response2.body);
    // print(extractedData);
   
    return extractedData;
  }
  // try {
  //  final response = await http.get(Uri.parse(url));
  //  List<dynamic> extractedData = jsonDecode(response.body);
  //  print(extractedData);
  //  return extractedData;
  // }
 
  catch (error) {
    // print(error);
    return {"error" : "sorry"};
  }
 
  }
 
  // Future<Map<dynamic, dynamic>> _replies = Future(foo);
           
  // List<dynamic> accountList = [];
   
 
 
  @override
  Widget build(BuildContext context) {
  //  print(list);
  //  print(list.length);
    return SizedBox(
      height: 300,
      child:ListView.builder(
      itemCount: list['forums'].length,
      itemBuilder: (context, i) {
        // print(list['forums'][i]['fields']['author']);
        // print(getAuthor(list['forums'][i]['fields']['author']));
        // print(list);
         
          // print("\n");
          // print("\n");
       
        // print(i);
          // fetchData(list['forums'][i]['pk']).then((val) => setState(() {
          // // //   print("=========================");
          // // //   print(val);
          //       _replies = val;
          //     }));
         
          // Map _replies = {"" : ""};
          // Future _replies = fetchData(list['forums'][i]['pk']);
 
          // fetchData(list['forums'][i]['pk']);
         
          //     _replies = value;
          // });
            // print(list);
 
          // // print("\n");
          // // print("\n");
          // // print("\n");
          // print("\n");
       
        // print('http://127.0.0.1:8000/question/${parentID}/discussion/${list['forums'][i]['pk']}/json');
 
        // _replies = jsonDecode(http.get(Uri.parse('http://127.0.0.1:8000/question/${parentID}/discussion/${list['forums'][i]['pk']}/json')));
 
 
        // print(_replies);
 
        String a = getAuthor(list['forums'][i]['fields']['author']);
        String time = list['forums'][i]['fields']['created_at'];
        // print(a);
        // print(time);
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context)=> const Text('data')
              )
            ),
           
            child: Column(
              children: <Widget>[
                Text('${list['forums'][i]['fields']['body']}'),
                Text('dibuat oleh '+a+' pada '+time.substring(0, 10)+' pukul ${time.substring(11, 19)}'),
 
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

