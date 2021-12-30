import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pedulilindungi2_mobile_app/common/cookie_request.dart';
import '../profil_penerima.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String nama = '';
  String nik = '';
  String nomorHP = '';
  String alamat = '';
  String gender = 'Jenis Kelamin';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TextEditingController dateCtl = TextEditingController();
  List<String> disabledItems = <String>['Jenis Kelamin'];
  List<String> items = <String>['Jenis Kelamin', 'Laki-laki', 'Perempuan'];

  bool initialized = false;
  bool nilaiCheckBox = false;
  bool nilaiSwitch = true;
  late DateTime selectedData;

  void setInitState() async {
    final request = context.watch<CookieRequest>();
    String usn = request.username;
    String url = 'http://10.0.2.2:8000/profil-penerima/user/flutter/' + usn;
    Map<String, dynamic> data = {};
    try {
      final response = await http.get(Uri.parse(url));
      data['profile'] = jsonDecode(response.body);

      _nameController.text = data['profile'][1]['fields']['namaLengkap'];
      nama = _nameController.text;

      _nikController.text = data['profile'][1]['fields']['NIK'].toString();
      nik = _nikController.text;

      _nomorController.text = data['profile'][1]['fields']['nomorHandphone'].toString();
      nomorHP = _nomorController.text;

      _alamatController.text = data['profile'][1]['fields']['alamat'].toString();
      alamat = _alamatController.text;

      dateCtl.text = data['profile'][1]['fields']['tanggalLahir'].toString();
      selectedDate = DateTime.parse(data['profile'][1]['fields']['tanggalLahir']);

      gender = data['profile'][1]['fields']['jenisKelamin'];
    }
    catch (error) {
      // print(error);
    }

    initialized = true;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _nikController.dispose();
    super.dispose();
  }


  void printHasil() {
      print("Nama Peserta: " + nama);
      print("NIK: " + nik);
      print("Nomor HP: " + nomorHP);
      print("Tanggal Lahir: " + selectedDate.toString());
      print("Gender: " + gender);
      print("Alamat: " + alamat);
    }

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

  Future<String> postData(CookieRequest request) async {
    request.isBiodata = true;
    String usn = request.username;
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/profil-penerima/profile/edit/flutter/" + usn),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'namaLengkap': nama,
          'nik': nik,
          'tanggalLahir': dateCtl.text,
          'jenisKelamin': gender,
          'nomorHandphone': nomorHP,
          'alamat': alamat,
          'username': request.username
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    print(extractedData);
    return extractedData["msg"];
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if(!initialized){
      setInitState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nikController,
                    autocorrect: false,
                    maxLength: 16,
                    decoration: InputDecoration(
                      labelText: "NIK",
                      icon: const Icon(Icons.card_membership),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      } else if (value.toString().length != 16) {
                        return "NIK Anda tidak valid!";
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      // setState(() {
                        nik = value!;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      icon: const Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                      // sources https://stackoverflow.com/questions/43935255/regular-expression-for-name-with-spaces-allowed-in-between-the-text-and-avoid-sp
                    } else if (!value
                        .toString()
                        .contains(RegExp(r'^(?![\s.]+$)[a-zA-Z\s.]*$'))) {
                      return "Tolong masukkan nama yang benar!";
                    }
                    return null;
                  },
                    onChanged: (String? value) {
                      // setState(() {
                        nama = value!;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Jenis Kelamin",
                          icon: Icon(Icons.person_sharp),
                            errorStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            
                        isDense: true, // reduce height of the button.
                        isExpanded: true,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        // underline: DropdownButtonHideUnderline(child: Container()),
                        value: gender,
                        onChanged: (String? value) {
                          if (!disabledItems.contains(value)) {
                            // setState(() {
                              gender = value!;
                            // });
                          }
                        },
                        items: items
                            .map<DropdownMenuItem<String>>((String gender) {
                          return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                style: TextStyle(
                                    color: disabledItems.contains(gender)
                                        ? Colors.black54
                                        : null,
                                    fontSize: 20),
                              ));
                        }).toList(),
                        validator: (value) {
                          if (value == 'Jenis Kelamin') {
                            return '*Required';
                          }
                          // return null,
                        }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nomorController,
                    maxLength: 12,
                    decoration: InputDecoration(
                      labelText: "Nomor Handphone",
                      icon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                        return '*Required';
                      } else if (value.toString().length != 12) {
                        return "Nomor HP Anda tidak valid!";
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      // setState(() {
                        nomorHP = value!;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      icon: const Icon(Icons.streetview),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                          return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      // setState(() {
                        alamat = value!;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                  // sources https://stackoverflow.com/questions/54127847/flutter-how-to-display-datepicker-when-textformfield-is-clicked
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (picked != null && picked != selectedDate) {
                      // setState(() {
                        selectedDate = picked;
                      // });
                    }
                    dateCtl.text = selectedDate.toString().substring(0, 10);
                    // method toIso8601String
                  },
                  controller: dateCtl,
                  decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      icon: Icon(Icons.calendar_today),
                      labelText: 'Tanggal Lahir',
                      counterText: '',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      labelStyle: TextStyle(fontSize: 20),),
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    // return null,
                  }),
            
                ),
                ElevatedButton(
                  child: const Text(
                    "Simpan Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      printHasil();
                      postData(request);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MainProfilePenerima()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
