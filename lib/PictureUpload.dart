import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'TimelinePage.dart';

class PictureUpload extends StatefulWidget {
  @override
  _PictureUploadState createState() => _PictureUploadState();
}

class _PictureUploadState extends State<PictureUpload> {
  File sampleImage;
  String _values;
  String url;
  final formKey = new GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
  }

  void uploadImage() async {
    if(validateAndSave()) {
      final StorageReference postPictureRef = FirebaseStorage.instance.ref().child("Post Pictures");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = postPictureRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = ImageUrl.toString();
      print("Image URL : " + url);
      saveToDatabase(url);
      gotoTimelinePage();
    }
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var dateFormat = new DateFormat('MMM d, yyyy');
    var timeFormat = new DateFormat('EEE, hh:mm aaa');
    String date = dateFormat.format(dbTimeKey);
    String time = timeFormat.format(dbTimeKey);
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": _values,
      "date": date,
      "time": time, 
    };
    dbRef.child("Posts").push().set(data);
  }

  gotoTimelinePage() {
    Navigator.push (
      context, 
      MaterialPageRoute (
        builder: (context) {
          return new TimelinePage();
        }
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar (
        backgroundColor: Colors.pinkAccent.shade100,
        title: new Text("Sada-e-Niswaan"),
        centerTitle: true,
      ),
      body: new Center (
        child: sampleImage == null? Text("Select an Picture"): enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton (
        backgroundColor: Colors.pinkAccent.shade100,
        onPressed: getImage,
        tooltip: 'Add Image',
        child: Icon(Icons.add_a_photo),
        ),
    );
  }

  Widget enableUpload() {
    return Container (
      child: new Form (
      key: formKey,
      child: new Column (
        children: <Widget> [
          Image.file(sampleImage, height: 330.0, width: 660.0),
          
          SizedBox(height: 15.0),
          
          TextFormField (
            decoration: new InputDecoration (
              labelText: 'Description',
            ),
            validator: (value) {
              return value.isEmpty? 'Description is Required' : null;
            },
            onSaved: (value) {
              _values = value;
            },
          ),

          SizedBox(height: 15.0),
          
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
               ),
            elevation: 10.0,
            child: Text('Submit Post'),
            textColor: Colors.white,
            color: Colors.pinkAccent.shade100,
            onPressed: uploadImage,
          )
          
        ],
      )
     
      ),
     );
  }
}