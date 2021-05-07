import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class ForgetPWPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProsesForgotPW(),
    );
  }
}

class ProsesForgotPW extends StatefulWidget {
  @override
  _ProsesForgotPWState createState() => _ProsesForgotPWState();
}

class _ProsesForgotPWState extends State<ProsesForgotPW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: FormForgotPW(),
    );
  }
}

class FormForgotPW extends StatefulWidget {
  @override
  _FormForgotPWState createState() => _FormForgotPWState();
}

class _FormForgotPWState extends State<FormForgotPW> {
  GlobalKey<FormState> forgotPWKey = GlobalKey<FormState>();

  TextEditingController forgotEmailController = TextEditingController();

  String verifyLink;
  Future<dynamic> checkUser() async {
    var response = await http.post('http://192.168.1.8/tanampedia/cekEmail.php',
        body: {"email": forgotEmailController.text});

    var link = json.decode(response.body);
    if (link == "User Tidak Ada") {
      AlertDialog(
        title: Text("User Tidak ada"),
      );
    } else {
      setState(() {
        verifyLink = link;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final judul = Padding(
        padding: EdgeInsets.only(top: 250.0),
        child: Text('Lupa Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));

    final deskripsi = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Silahkan Ubah Password Anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));

    final email = Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: forgotEmailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 10),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5)),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email Tidak Boleh Kosong';
          } else if (!EmailValidator.validate(value)) {
            return "Invalid Email";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );

    final buttonSubmit = Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton.icon(
        icon: Icon(Icons.app_registration),
        label: Text(
          'Ubah Password',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          checkUser();
        }, //validasi(context),
        color: Colors.white,
        textColor: Colors.green,
      ),
    );

    return Form(
        key: forgotPWKey,
        child: SingleChildScrollView(
            child: Column(children: [
          judul,
          deskripsi,
          email,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [buttonSubmit],
          ),
        ])));
  }
}
