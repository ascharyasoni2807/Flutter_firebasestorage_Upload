import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File sampleVideo;
  File sampleImage;
  final picker = ImagePicker();
  List<firebase_storage.StorageUploadTask> _uploadTasks = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blue,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 250,
                ),
                Container(
                  padding: EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          uploadVideo();
                        },
                        child: Text("upload video"),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      RaisedButton(
                        onPressed: () {
                          uploadPic();
                        },
                        child: Text("upload image"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadVideo() async {
    String a;

    final pickedFile = await ImagePicker().getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        sampleVideo = File(pickedFile.path);
        a = basename(pickedFile.path);
        print(a);
        print(pickedFile.path);
      } else {
        print("none");
      }
    });
    firebase_storage.StorageReference reference =
        firebase_storage.FirebaseStorage.instance.ref().child('$a');

    firebase_storage.StorageUploadTask uploadTask = reference.putFile(
        await sampleVideo,
        firebase_storage.StorageMetadata(contentType: 'video/mp4'));
  }

  Future uploadPic() async {
    String a;
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        sampleImage = File(pickedFile.path);
        print(pickedFile.path);
        a = basename(pickedFile.path);
        print(a);
      } else {
        print("none");
      }
    });
    firebase_storage.StorageReference reference =
        firebase_storage.FirebaseStorage.instance.ref().child('$a');

    firebase_storage.StorageUploadTask uploadTask = reference.putFile(
        await sampleImage,
        firebase_storage.StorageMetadata(contentType: 'image/jpg'));
  }
}
