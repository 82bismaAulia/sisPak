import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:tanampedia/adminpage.dart';
import 'package:tanampedia/lupapw.dart';
import 'package:tanampedia/masterdata.dart';
import 'package:tanampedia/memberpage.dart';
import 'package:tanampedia/menutanaman.dart';
import 'package:tanampedia/register.dart';
import 'package:tanampedia/tambahtanah.dart';
import 'package:tanampedia/tanahedit.dart';
import 'package:tanampedia/tanamantambah.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProsesLogin(),
      routes: <String, WidgetBuilder>{
        '/adminpage': (BuildContext context) => new AdminPage(),
        '/memberpage': (BuildContext context) => new MemberPage(),
        '/proseslogin': (BuildContext context) => new ProsesLogin(),
        '/prosesregister': (BuildContext context) => new ProsesRegister(),
        '/prosesforgotpw': (BuildContext context) => new ProsesForgotPW(),
        '/prosestanahtambah': (BuildContext context) => new ProsesTambahTanah(),
        '/masterdata': (BuildContext context) => new MasterData(),
        '/tanahedit': (BuildContext context) => new TanahEdit(),
        '/menutanaman': (BuildContext context) => new MenuTanaman(),
        '/prosestanamantambah': (BuildContext context) =>
            new ProsesTambahTanaman(),
      },
    );
  }
}

class ProsesLogin extends StatefulWidget {
  @override
  _ProsesLoginState createState() => _ProsesLoginState();
}

class _ProsesLoginState extends State<ProsesLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: FormLogin(),
    );
  }
}

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controller
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textNIMController = TextEditingController();

  String msg = '';

  // ignore: missing_return
  Future<dynamic> _login() async {
    final response =
        await http.post("http://192.168.1.9/tanampedia/login.php", body: {
      "email": textEmailController.text,
      "pw": textNIMController.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Gagal";
      });
    } else {
      if (datauser[0]['peran'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/adminpage');
      } else if (datauser[0]['peran'] == 'member') {
        Navigator.pushReplacementNamed(context, '/memberpage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final judul = Padding(
        padding: EdgeInsets.only(top: 250.0),
        child: Text('TANAMPEDIA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));

    final deskripsi = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Silahkan Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));

    final inputEmail = Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEmailController,
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

    final inputPw = Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: TextFormField(
          controller: textNIMController,
          obscureText: true,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5)),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            return value.isEmpty ? "Password Tidak Boleh Kosong" : null;
          },
        ));

    final lupaPw = Container(
      alignment: Alignment.bottomRight,
      child: FlatButton(
        //color: Colors.blue,
        child: Text(
          'Lupa Password ?',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          // Navigator.pushReplacementNamed(context, '/prosesforgotpw');
        },
      ),
    );

    final buttonSubmit = Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton.icon(
        icon: Icon(Icons.send),
        label: Text(
          'Masuk',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          _login();
        }, //validasi(context),
        color: Colors.white,
        textColor: Colors.green,
      ),
    );

    final buttonRegister = Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton.icon(
        icon: Icon(Icons.add_box),
        label: Text(
          'Buat Akun',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () => {
          Navigator.pushReplacementNamed(context, '/prosesregister')
        }, //validasi(context),
        color: Colors.white,
        textColor: Colors.green,
      ),
    );

    final pesan = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        msg,
        style: TextStyle(fontSize: 12.0, color: Colors.red),
      ),
    );

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              judul,
              deskripsi,
              //email,
              inputEmail,
              //pw,
              inputPw,
              lupaPw,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [buttonSubmit, buttonRegister],
              ),
              pesan
            ],
          ),
        ),
      ),
    );
  }
}
