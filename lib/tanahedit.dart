import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tanampedia/masterdata.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class TanahEdit extends StatefulWidget {
  final Map tanah2;
  TanahEdit({this.tanah2});

  @override
  _TanahEditState createState() => _TanahEditState();
}

class _TanahEditState extends State<TanahEdit> {
  GlobalKey<FormState> editDataTanah = GlobalKey<FormState>();

  File _image;

  Future getImageGallery() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = imageFile;
    });
  }

  TextEditingController namaTanahController;
  TextEditingController deskripsiTanahController;

  void editData() async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();
      var url = Uri.parse("http://192.168.1.9/tanampedia/tanahedit.php");
      var request = http.MultipartRequest("POST", url);
      request.fields['id'] = widget.tanah2['id'];
      request.fields['nama'] = namaTanahController.text;
      request.fields['deskripsi'] = deskripsiTanahController.text;
      request.files.add(http.MultipartFile("gambar", stream, length,
          filename: path.basename(_image.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("Gambar Berhasil diUpload");
      } else {
        print("Gambar Gagal diupload");
      }
    } catch (e) {
      debugPrint(e);
    }
    /*var url = "http://192.168.1.9/tanampedia/tanahedit.php";
    http.post(url, body: {
      'id': widget.tanah2['id'],
      "nama": namaTanahController.text,
      "deskripsi": deskripsiTanahController.text
    });*/
  }

  @override
  void initState() {
    namaTanahController =
        new TextEditingController(text: widget.tanah2['nama']);
    deskripsiTanahController =
        new TextEditingController(text: widget.tanah2['deskripsi']);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Data"),
        ),
        body: Form(
          key: editDataTanah,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                new Column(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          getImageGallery();
                        },
                        //padding: const EdgeInsets.all(10.0),
                        child: _image == null
                            ? Image.network(
                                "http://192.168.1.12/tanampedia/upload/${widget.tanah2['gambar']}")
                            : new Image.file(_image),
                      ),
                    ),
                    new TextField(
                      controller: namaTanahController,
                      decoration: new InputDecoration(
                        hintText: "Nama Tanah",
                        labelText: "Nama Tanah",
                      ),
                    ),
                    new TextField(
                      controller: deskripsiTanahController,
                      decoration: new InputDecoration(
                          hintText: "Deskripsi", labelText: "Deskripsi"),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _image == null
                          ? new Text(
                              "Tidak Ada Gambar yang Dipilih, Silahkan Pilih Gambar")
                          : new Image.file(_image),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new RaisedButton(
                          child: Icon(Icons.image),
                          onPressed: getImageGallery,
                        ),
                        new RaisedButton(
                          child: Icon(Icons.camera),
                          onPressed: getImageCamera,
                        ),
                      ],
                    ),*/
                    new RaisedButton(
                      child: new Text(
                        "Edit Data",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        editData();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Berhasil Diupdate !",
                                  style: TextStyle(color: Colors.green),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text("Oke"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MasterData()));
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
