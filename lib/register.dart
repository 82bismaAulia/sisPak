import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:tanampedia/login.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProsesRegister(),
      routes: <String, WidgetBuilder>{
        '/proseslogin': (BuildContext context) => new ProsesLogin(),
      },
    );
  }
}

class ProsesRegister extends StatefulWidget {
  @override
  _ProsesRegisterState createState() => _ProsesRegisterState();
}

class _ProsesRegisterState extends State<ProsesRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: FormRegister(),
    );
  }
}

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  TextEditingController regNamaController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPWController = TextEditingController();

  void tambahData() {
    var url = "http://192.168.1.9/tanampedia/registambah.php";

    http.post(url, body: {
      "nama": regNamaController.text,
      "email": regEmailController.text,
      "pw": regPWController.text,
      "peran": 'member',
    });
  }

  @override
  Widget build(BuildContext context) {
    final judul = Padding(
        padding: EdgeInsets.only(top: 250.0),
        child: Text('Register',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));

    final deskripsi = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Silahkan Register',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));

    final email = Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: regEmailController,
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

    final nama = Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: regNamaController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 10),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5)),
          labelText: 'Nama',
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: (String value) {
          Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z0-0]+)*$';
          RegExp regex = new RegExp(pattern);
          if (value.isEmpty) {
            return 'Nama Tidak Boleh Kosong';
          } else if (!regex.hasMatch(value)) {
            return 'Nama Tidak Valid';
          } else {
            return null;
          }
        },
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      ),
    );

    final pw = Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: TextFormField(
          controller: regPWController,
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

    final buttonSubmit = Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton.icon(
        icon: Icon(Icons.app_registration),
        label: Text(
          'Daftar',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () => {
          tambahData(),
          Navigator.pushReplacementNamed(context, '/proseslogin'),
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Anda Berhasil Daftar",
                    style: TextStyle(color: Colors.green),
                  ),
                  actions: [
                    FlatButton(
                      child: Text("Oke"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              })
        }, //validasi(context),
        color: Colors.white,
        textColor: Colors.green,
      ),
    );

    return Form(
        key: registerKey,
        child: SingleChildScrollView(
            child: Column(children: [
          judul,
          deskripsi,
          email,
          nama,
          pw,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [buttonSubmit],
          ),
        ])));
  }
}
