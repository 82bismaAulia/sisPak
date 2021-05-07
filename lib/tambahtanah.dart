//import 'dart:html';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:tanampedia/masterdata.dart';

class ProsesTambahTanah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Tambah Tanah"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
                onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MasterData())))
          ],
        ),
      ),
    );
  }
}

class TambahDataTanah extends StatefulWidget {
  @override
  _TambahDataTanahState createState() => _TambahDataTanahState();
}

class _TambahDataTanahState extends State<TambahDataTanah> {
  GlobalKey<FormState> addTanahKey = GlobalKey<FormState>();
  File _image;

  Future getImageGallery() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = imageFile;
    });
  }

  Future getImageCamera() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = imageFile;
    });
  }

  TextEditingController namaTanahController = TextEditingController();
  TextEditingController deskripsiTanahController = TextEditingController();

  void tambahData() async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();
      var url = Uri.parse("http://192.168.1.9/tanampedia/tanahtambah.php");
      var request = http.MultipartRequest("POST", url);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Data Tanah"),
          backgroundColor: Colors.green,
        ),
        body: Form(
          key: addTanahKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                new Column(
                  children: [
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
                    Padding(
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
                    ),
                    new RaisedButton(
                      child: new Text(
                        "Tambah Data",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        tambahData();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Berhasil Ditambahkan !",
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
