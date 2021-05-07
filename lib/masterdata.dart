import 'dart:convert';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tanampedia/tambahtanah.dart';
import 'package:tanampedia/tanahdetail.dart';
import 'package:tanampedia/tanahedit.dart';
//import 'package:path/path.dart';

class MasterData extends StatefulWidget {
  @override
  _MasterDataState createState() => _MasterDataState();
}

class _MasterDataState extends State<MasterData> {
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.9/tanampedia/tanahtampil.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master Data Tanah"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new TambahDataTanah())),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            /*gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Colors.green[100], Colors.white])*/
            image: DecorationImage(
                image: AssetImage("images/1.png"), fit: BoxFit.fill)),
        child: new FutureBuilder<dynamic>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      //return ListTile(
                      //title: Container(
                      //margin: EdgeInsets.all(5.0),
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            side: BorderSide(color: Colors.green, width: 1),
                          ),
                          elevation: 5,
                          /*onPressed: () {},
                            highlightedBorderColor: Colors.black,
                            splashColor: Colors.green[300],*/
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TanahDetail(
                                                  tanah:
                                                      snapshot.data[index])));
                                    },
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            "http://192.168.1.9/tanampedia/upload/${list[index]['gambar']}",
                                            width: 200,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5.0),
                                        ),
                                        Text(
                                          list[index]['nama'],
                                          textAlign: TextAlign.center,
                                        ),

                                        //Divider(),
                                        ButtonTheme.bar(
                                          child: ButtonBar(
                                            buttonPadding:
                                                EdgeInsets.only(top: 9.0),
                                            alignment: MainAxisAlignment.center,
                                            buttonHeight: 15,
                                            children: [
                                              FlatButton(
                                                child: const Text(
                                                  "Edit",
                                                ),
                                                onPressed: () => Navigator.of(
                                                        context)
                                                    .push(new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            new TanahEdit(
                                                              tanah2: snapshot
                                                                  .data[index],
                                                            ))),
                                                splashColor: Colors.green,
                                              ),
                                              /*FlatButton(
                                                child: const Text("Hapus"),
                                                onPressed: () => confirm(),
                                                splashColor: Colors.green,
                                              )*/
                                              ConfirmButton(
                                                tanahdata: snapshot.data[index],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /*Padding(
                              padding: EdgeInsets.only(top: 5.0),
                            ),*/
                              ]));
                      //),
                      //);
                    },
                  )
                : new Center(child: new CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ConfirmButton extends StatefulWidget {
  final Map tanahdata;

  ConfirmButton({this.tanahdata});
  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  void deleteData() {
    var url = "http://192.168.1.9/tanampedia/tanahhapus.php";
    http.post(url, body: {
      "id": widget.tanahdata['id'],
    });
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Yakin untuk menghapus data ini? "),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () {
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new MasterData()));
          },
          child: new Text(
            "Hapus",
            style: TextStyle(color: Colors.black),
          ),
          color: Colors.red,
        ),
        new RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: new Text("Batal", style: TextStyle(color: Colors.black)),
          color: Colors.green,
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
      child: const Text("Hapus"),
      onPressed: () => confirm(),
      splashColor: Colors.green,
    ));
  }
}
