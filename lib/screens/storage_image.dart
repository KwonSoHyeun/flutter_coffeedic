import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

CloudStorageDemoState pageState;

class CloudStorageDemo extends StatefulWidget {
  @override
  CloudStorageDemoState createState() {
    pageState = CloudStorageDemoState();
    return pageState;
  }
}

class CloudStorageDemoState extends State<CloudStorageDemo> {
  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Cloud Storage Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 업로드할 이미지를 출력할 CircleAvatar
            CircleAvatar(
              backgroundImage:
                  (_image != null) ? FileImage(_image) : NetworkImage(""),
              radius: 30,
            ),
            // 업로드할 이미지를 선택할 이미지 피커 호출 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Gallery"),
                  onPressed: () {
                    handleUploadType('gallery');
                  },
                ),
                RaisedButton(
                  child: Text("Camera"),
                  onPressed: () {
                    handleUploadType('camera');
                  },
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            // 업로드 된 이미지를 출력할 CircleAvatar
            CircleAvatar(
              backgroundImage: NetworkImage(_profileImageURL),
              radius: 30,
            ),
            // 업로드 된 이미지의 URL
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_profileImageURL),
            )
          ],
        ),
      ),
    );
  }

  void handleUploadType(String type) async {
    PickedFile file;

    if (type == 'gallery') {
      file = await ImagePicker().getImage(source: ImageSource.gallery);
    } else {
      file = await ImagePicker().getImage(source: ImageSource.camera);
    }

    if (file == null) return;
    setState(() {
      _image = File(file.path);
    });

    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    String newFileName = _user.email.split('@')[0] +
        DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference =
        _firebaseStorage.ref().child("coffeebaseimage/$newFileName");

    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("uploading file...")
          ],
        ),
      ));

    // 파일 업로드
    UploadTask storageUploadTask = storageReference.putFile(_image);

    // 파일 업로드 완료까지 대기
    await storageUploadTask.whenComplete(null);

    // 업로드한 사진의 URL 획득
    String downloadURL = await storageReference.getDownloadURL();

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
      _scaffoldKey.currentState.hideCurrentSnackBar();
    });
  }
}
