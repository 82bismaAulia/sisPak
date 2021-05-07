//import 'dart:convert';
//import 'dart:js';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:tanampedia/tambahtanah.dart';
import 'package:tanampedia/tanamantambah.dart';

//import 'package:path/path.dart';

class MenuTanaman extends StatefulWidget {
  @override
  _MenuTanamanState createState() => _MenuTanamanState();
}

class _MenuTanamanState extends State<MenuTanaman> {
  /*Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.12/tanampedia/tanahtampil.php");
    return json.decode(response.body);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Master Data Tanaman"),
          backgroundColor: Colors.green,
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new ProsesTambahTanaman())),
          backgroundColor: Colors.green,
        ),
        body: Container());
  }
}
