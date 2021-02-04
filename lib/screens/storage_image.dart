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
  User _user;
  String _profileImageURL;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser;
    if (_user != null) {}
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
            // // 업로드할 이미지를 출력할 CircleAvatar
            // CircleAvatar(
            //   backgroundImage:
            //       (_image != null) ? FileImage(_image) : NetworkImage(""),
            //   radius: 30,
            // ),
            // 업로드할 이미지를 선택할 이미지 피커 호출 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    backgroundImage: (_profileImageURL != null)
                        ? NetworkImage(_profileImageURL)
                        : ExactAssetImage('assets/camera.png'),
                    radius: 30,
                  ),
                ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              //child: Text(_profileImageURL),
            )
          ],
        ),
      ),
    );
  }

  void handleUploadType(String type) async {
    PickedFile file;

    if (type == 'gallery') {
      file = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
    } else {
      file = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
    }

    if (file == null) return;
    setState(() {
      _image = File(file.path);
    });

    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    String newFileName = _user.email.split('@')[0] +
        DateTime.now().millisecondsSinceEpoch.toString();
    print("newFileName:######" + newFileName);
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
    await storageUploadTask.whenComplete(() {
      null;
    });

    // 업로드한 사진의 URL 획득
    String downloadURL = await storageReference.getDownloadURL();

    print("downloadURL:######" + downloadURL);

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
    });

    //업로드가 끝나고도 화면에 사진이 보이는 시간이 좀 걸리기 때문에 추가 시간이 필요하다.
    await new Future.delayed(const Duration(seconds: 3));
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }
}
