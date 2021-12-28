// ignore_for_file: avoid_print

library biodata;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BiodataPeserta extends StatefulWidget {
  const BiodataPeserta({Key? key}) : super(key: key);
  @override
  BiodataPesertaState createState() {
    return BiodataPesertaState();
  }
}

class BiodataPesertaState extends State<BiodataPeserta> {
  final _formKey = GlobalKey<FormState>();
  String namaPeserta = '';
  String nik = '';
  String nomorHP = '';
  String gender = 'Jenis Kelamin';
  String alamat = '';
  List<String> disabledItems = <String>['Jenis Kelamin'];
  List<String> items = <String>['Jenis Kelamin', 'Laki-laki', 'Perempuan'];
  DateTime selectedDate = DateTime.now();
  TextEditingController dateCtl = TextEditingController();
  final myController = TextEditingController();

  void printHasil() {
    print("Nama Peserta: " + namaPeserta);
    print("NIK: " + nik);
    print("Nomor HP: " + nomorHP);
    print("Tanggal Lahir: " + dateCtl.text);
    print("Gender: " + gender);
    print("Alamat: " + alamat);
  }

  Future<String> postData() async {
    final response = await http.post(
        Uri.parse("https://pedulilindungi2.herokuapp.com/biodata/peserta/flutter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'namaLengkap': namaPeserta,
          'nik': nik,
          'tanggalLahir': dateCtl.text,
          'jenisKelamin': gender,
          'nomorHandphone': nomorHP,
          'alamat': alamat,
        }));

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    return extractedData["msg"];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        // padding: const EdgeInsets.only(left: 25, right: 35),
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 15),
            child: const Text('BIODATA PESERTA',
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
                    icon: Icon(Icons.person),
                    hintText: 'Masukkan nama lengkap kamu',
                    labelText: 'Nama Lengkap',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                onChanged: (String? value) {
                  setState(() {
                    namaPeserta = value!;
                  });
                },
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
                    icon: Icon(Icons.credit_card_outlined),
                    hintText: 'Masukkan NIK kamu',
                    labelText: 'NIK',
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
                    nik = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  } else if (value.toString().length != 16) {
                    return "NIK Anda tidak valid!";
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
                    hintText: 'Masukkan nomor handphone kamu',
                    labelText: 'Nomor Handphone',
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                maxLength: 12,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                onChanged: (String? value) {
                  setState(() {
                    nomorHP = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  } else if (value.toString().length != 12) {
                    return "Nomor HP Anda tidak valid!";
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
                // sources https://stackoverflow.com/questions/54127847/flutter-how-to-display-datepicker-when-textformfield-is-clicked
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
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
                    labelStyle: TextStyle(fontSize: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  }
                  // return null,
                }),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: InputDecorator(
                  decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      icon: Icon(Icons.person_outline_outlined),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                      isDense: true, // reduce height of the button.
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      // underline: DropdownButtonHideUnderline(child: Container()),
                      value: gender,
                      onChanged: (String? value) {
                        if (!disabledItems.contains(value)) {
                          setState(() {
                            gender = value!;
                          });
                        }
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String gender) {
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
                      }))),
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
                    hintText: 'Masukkan alamat tinggal kamu',
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
                    return "Alamat Anda tidak valid!";
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
                                              const Color(0xEA068F1C),
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
                                          const Color(0xFFFF0000),
                                    ),
                                    // sources https://docs.flutter.dev/cookbook/navigation/navigation-basics
                                    onPressed: () async {
                                      String message = await postData();
                                      
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
                                                        onPressed: () => {},
                                                        // TODO : arahin ke halaman berikutnya setelah mengisi biodata 
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
    );
  }
}