import 'package:flutter/material.dart';
import 'dart:ui';

class MenuMasterData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.my_library_books),
        title: Text("Menu Master Data"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Colors.green[100], Colors.white])),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Silahkan Input Data-Data yang Berkaitan dengan Master Data Pakar",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.greenAccent,
                    child: OutlineButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/masterdata');
                      },
                      highlightedBorderColor: Colors.black,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/soil.png",
                            width: 80.0,
                            height: 80.0,
                          ),
                          Text(
                            "Master Data Tanah",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.greenAccent,
                    child: OutlineButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/menutanaman');
                      },
                      highlightedBorderColor: Colors.black,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/plant.png",
                            width: 80.0,
                            height: 80.0,
                          ),
                          Text(
                            "Master Data Tanaman",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
