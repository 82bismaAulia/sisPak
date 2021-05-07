//import 'dart:html';

import 'package:flutter/material.dart';

class TanahDetail extends StatelessWidget {
  final Map tanah;
  TanahDetail({this.tanah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tanah Jenis " + tanah['nama']),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      child: Image.network(
                        "http://192.168.1.9/tanampedia/upload/${tanah['gambar']}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Center(
                      child: Text(
                        tanah['nama'],
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        tanah['deskripsi'],
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
