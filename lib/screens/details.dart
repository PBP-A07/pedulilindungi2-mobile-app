import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';

// This is class for show replies of each questions
class Detail extends StatefulWidget {
  final List list;
  final int index;
  const Detail({Key? key, required this.index, required this.list}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}
 
class _DetailState extends State<Detail> {
  final _formKey = GlobalKey<FormState>();
  var jawaban = "";
 
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
 
  // This function is for posting replies to django
  Future<String> postData(CookieRequest request) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/post-jawaban-flutter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'body' : jawaban,
        'username' : request.username,
        'forum' : widget.list[widget.index]["pk"]
      })
    );
  
    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData["msg"];
  } 

  // This is function for fetching each question's replies
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
  
    catch (error) {
      return {"error" : "sorry"};
    }
 
  }
 
 
 
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return  Scaffold(
      appBar: AppBar(title: Text("${widget.list[widget.index]['fields']['title']}")),
      body: Container(
        color: Colors.white,
        height: 1000,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                Text("${widget.list[widget.index]['fields']['body']}", style: const TextStyle(fontSize: 18.0),),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Masukkan jawaban Anda",
                            labelText: "Jawaban",
                          ),

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Jawaban tidak boleh kosong';
                            }
                            jawaban = value;
                            return null;
                          },
                        ),

                        const SizedBox(height:25.0),
                        
                        ElevatedButton(
                          child: Ink(
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                            child: const Text("Kirim Jawaban", 
                              style: TextStyle(
                              color: Colors.white,
                              )
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              postData(request);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detail(list: widget.list, index: widget.index,)),
                              );                                        
                            }  
                          }
                        ) 
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError){}
                    return snapshot.hasData
                    ? ItemList(
                      list: snapshot.data as Map,
                      parentID: widget.list[widget.index]['pk'],
                    )
                    : const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                )
              ]
            ),
          )
        )
      )
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
  State<ItemList> createState() {
    return _ItemState();
  }
}
 
class _ItemState extends State<ItemList> {
  String getAuthor(pk) {
    for (var auth in widget.list['accounts']) {
      if (auth["pk"] == pk) {
        return auth['fields']['username'];
      }
    }
    return "";
  }
 
  Future<Map<String, dynamic>> fetchData(i) async {
    String url = 'http://127.0.0.1:8000/question/' + widget.parentID.toString() + '/discussion/' + i + '/json';
    const url2 = 'http://127.0.0.1:8000/json-account';
  
    try {
      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> extractedData = {};
      extractedData['forums'] = jsonDecode(response.body);
    
      final response2 = await http.get(Uri.parse(url2));
      extractedData['accounts'] = jsonDecode(response2.body);
    
      return extractedData;
    }
    catch (error) {
      return {"error" : "sorry"};
    }
  }
 
 
  @override
  Widget build(BuildContext context) {
  
    return SizedBox(
      height: MediaQuery.of(context).size.height - 400,
      child:ListView.builder(
      itemCount: widget.list['forums'].length,
      itemBuilder: (context, i) {
 
        String a = getAuthor(widget.list['forums'][i]['fields']['author']);
        String time = widget.list['forums'][i]['fields']['created_at'];

        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context)=> const Text('data')
                )
              ),
           
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${widget.list['forums'][i]['fields']['body']}', style: const TextStyle(fontSize: 18),),
                  Text('dibuat oleh '+a+' pada '+time.substring(0, 10)+' pukul ${time.substring(11, 19)}'),
  
                ],
 
              ),
            ),
          );
        },
      )
    );
  }
}

