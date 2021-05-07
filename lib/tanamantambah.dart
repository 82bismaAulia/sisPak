//import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:tanampedia/masterdata.dart';

class ProsesTambahTanaman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TambahDataTanaman());
  }
}

class TambahDataTanaman extends StatefulWidget {
  @override
  _TambahDataTanamanState createState() => _TambahDataTanamanState();
}

class _TambahDataTanamanState extends State<TambahDataTanaman> {
  GlobalKey<FormState> addTanamanKey = GlobalKey<FormState>();
  File _image;

  /*bool selected = false;
  var dataTanah = List<bool>();
  Future<List> getDataTanah() async {
    var response =
        await http.get("http://192.168.1.12/tanampedia/tanahtampil.php");
    var jsonData = json.decode(response.body);

    List dataTanah2 = [];

    for (var u in jsonData) {
      var data = jsonData(u["id"], u["nama"]);

      dataTanah2.add(data);
      dataTanah.add(false);
    }
    print(dataTanah2.length);
    return dataTanah2;
  }*/

  Future getImageGallery() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = imageFile;
    });
  }

  //bool selected = false;
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.9/tanampedia/tanahtampil.php");
    return json.decode(response.body);
  }

  List<bool> selectedData;

  //void selectedChange(bool value) => setState(() => selected = value);

  //TextEditingController namaTanahController = TextEditingController();
  //TextEditingController deskripsiTanahController = TextEditingController();

  /*void tambahData() async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();
      var url = Uri.parse("http://192.168.1.12/tanampedia/tanahtambah.php");
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
  }*/

  @override
  void initState() {
    super.initState();
    //  getAllCategory();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Data Tanaman"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: addTanamanKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  new Column(
                    children: [
                      new TextField(
                        //controller: namaTanamanController,
                        decoration: new InputDecoration(
                          hintText: "Nama Tanaman",
                          labelText: "Nama Tanaman",
                        ),
                      ),
                      new TextField(
                        //controller: deskripsiTanamanController,
                        decoration: new InputDecoration(
                            hintText: "Deskripsi", labelText: "Deskripsi"),
                      ),
                      new TextField(
                        //controller: manfaatTanamanController,
                        decoration: new InputDecoration(
                            hintText: "Manfaat Tanaman",
                            labelText: "Manfaat Tanaman"),
                      ),
                      new TextField(
                        //controller: caraTanamanController,
                        decoration: new InputDecoration(
                            hintText: "Cara Menanam",
                            labelText: "Cara Menanam"),
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
                        ],
                      ),
                      new FutureBuilder<dynamic>(
                          future: getData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      //List list = snapshot.data;
                                      List<bool> checkboxvalues = List.filled(
                                          snapshot.data.length, false);
                                      return CheckboxListTile(
                                        title:
                                            Text(snapshot.data[index]['nama']),
                                        value: checkboxvalues[index],
                                        //selected: selected,
                                        //key: Key(snapshot.data[index]['id']),
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxvalues[index] = value;
                                          });
                                        },
                                        dense: true,
                                      );
                                    })
                                : new Center(
                                    child: new CircularProgressIndicator());
                          }),

                      /*CheckboxListTile(
                        value: selectedValue.,
                        onChanged: (bool value) {
                          setState(() {
                            dataTanah[valueId] = !dataTanah[valueId];
                          });
                        },
                        title: Text(selectedNama),
                        activeColor: Colors.red,
                        secondary: Icon(Icons.language),
                      ),*/
                      new RaisedButton(
                          child: new Text(
                            "Tambah Data",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.green,
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
