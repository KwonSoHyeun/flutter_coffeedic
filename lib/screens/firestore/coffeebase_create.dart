import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeedic/widgets/range_button.dart';

CoffeebasePageState pageState;

class CoffeebasePage extends StatefulWidget {
  final String documentID;
  final Coffee coffeeData;
  const CoffeebasePage(this.documentID, this.coffeeData);

  @override
  CoffeebasePageState createState() {
    pageState = CoffeebasePageState();
    return pageState;
  }
}

class CoffeebasePageState extends State<CoffeebasePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<int>> levelList = [];
  bool isAddState = true; //신규 생성 모드인지

  File _image;
  User _user;
  String _profileImageURL;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final picker = ImagePicker();

  User firebaseUser = FirebaseAuth.instance.currentUser;
  ValuePickerWidget range_aroma,
      range_body,
      range_sweet,
      range_acidity,
      range_bitterness,
      range_balance;

  @override
  void initState() {
    super.initState();
    _prepareService();

    range_aroma = ValuePickerWidget(
        lableText: "Aroma", iCounter: widget.coffeeData.aroma);
    range_body = ValuePickerWidget(
        lableText: "Body", iCounter: widget.coffeeData.acidity);
    range_sweet = ValuePickerWidget(
        lableText: "Sweet", iCounter: widget.coffeeData.sweet);
    range_acidity = ValuePickerWidget(
        lableText: "Acidity", iCounter: widget.coffeeData.balance);
    range_bitterness = ValuePickerWidget(
        lableText: "Bitterness", iCounter: widget.coffeeData.bitterness);
    range_balance = ValuePickerWidget(
        lableText: "Balanace", iCounter: widget.coffeeData.balance);
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser;
    if (_user == null) {
      //todo 로그인 페이지로 보낸다.
    }
  }

  @override
  Widget build(BuildContext context) {
    levelList = widget.coffeeData.loadLevelList();
    if (widget.coffeeData.name.isNotEmpty) {
      isAddState = false;
    }

    print("isAddState:#########" + isAddState.toString());

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Add new widget.coffeeData..."),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: new Column(children: <Widget>[
                nameField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                countryField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                cityField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                range_aroma.getValuePickerWidget(),
                range_body.getValuePickerWidget(),
                range_sweet.getValuePickerWidget(),
                range_acidity.getValuePickerWidget(),
                range_bitterness.getValuePickerWidget(),
                range_balance.getValuePickerWidget(),
                descField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                imageField(),
                Row(
                  children: <Widget>[
                    if (isAddState) submitButton(),
                    if (!isAddState) updateDeleteContainer(),
                  ],
                ),
              ])),
            )));
  }

  Widget submitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.coffeeData.aroma = range_aroma.iCounter;
              widget.coffeeData.body = range_body.iCounter;
              widget.coffeeData.sweet = range_sweet.iCounter;
              widget.coffeeData.acidity = range_acidity.iCounter;
              widget.coffeeData.bitterness = range_bitterness.iCounter;
              widget.coffeeData.balance = range_balance.iCounter;
              createDoc();
              Navigator.pop(this.context);
            }
          },
          // 버튼에 텍스트 부여
          child: Text('Submit'),
        ));
  }

  Widget updateDeleteContainer() {
    return Container(
      child: Row(
        children: <Widget>[
          updateButton(),
          deleteButton(),
        ],
      ),
    );
  }

  Widget updateButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.coffeeData.aroma = range_aroma.iCounter;
              widget.coffeeData.body = range_body.iCounter;
              widget.coffeeData.sweet = range_sweet.iCounter;
              widget.coffeeData.acidity = range_acidity.iCounter;
              widget.coffeeData.bitterness = range_bitterness.iCounter;
              widget.coffeeData.balance = range_balance.iCounter;
              updateDoc();
              Navigator.pop(this.context);
            }
          },
          // 버튼에 텍스트 부여
          child: Text('Update'),
        ));
  }

  Widget deleteButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            deleteDoc();
            Navigator.pop(this.context);
          },
          child: Text('Delete'),
          color: Colors.red[400],
        ));
  }

//커피명
  Widget nameField() {
    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(labelText: "name", hintText: '커피명을 입력해주세요'),
      // validator: (name) {
      //   if (name.isEmpty) {
      //     return '커피명을 입력하세요.';
      //   }
      //   return null;
      // },
      initialValue: widget.coffeeData.name,
      onSaved: (name) => widget.coffeeData.setName = name,
    );
  }

  //Country
  Widget countryField() {
    return TextFormField(
      autocorrect: false,
      decoration:
          InputDecoration(labelText: "country", hintText: '나라명을 입력해주세요'),
      validator: (country) {
        if (country.isEmpty) {
          return '나라명을 입력해주세요.';
        }
        return null;
      },
      initialValue: widget.coffeeData.country,
      onSaved: (country) => widget.coffeeData.setCountry = country,
    );
  }

  //City
  Widget cityField() {
    return TextFormField(
      //obscureText: true,
      decoration: InputDecoration(labelText: "city", hintText: '도시명을 입력해주세요'),
      // validator: (city) {
      //   if (city.isEmpty) {
      //     return '도시명을 입력하세요.';
      //   }
      //   return null;
      // },
      initialValue: widget.coffeeData.city,
      onSaved: (city) => widget.coffeeData.setCity = city,
    );
  }

//body
  Widget bodyField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "body", hintText: 'body'),
      value: widget.coffeeData.body,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.body = value;
        });
      },
      onSaved: (body) => widget.coffeeData.setBody = body,
    );
  }

//acidity
  Widget acidityField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "acidity", hintText: 'acidity'),
      value: widget.coffeeData.acidity,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.acidity = value;
        });
      },
      onSaved: (acidity) => widget.coffeeData.setAcitidy = acidity,
    );
  }

  //bitterness
  Widget bitternessField() {
    return DropdownButtonFormField(
      decoration:
          InputDecoration(labelText: "bitterness", hintText: 'bitterness'),
      value: widget.coffeeData.bitterness,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.bitterness = value;
        });
      },
      onSaved: (bitterness) => widget.coffeeData.setBitterness = bitterness,
    );
  }

  //balance
  Widget balanceField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "balance", hintText: 'balance'),
      value: widget.coffeeData.balance,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.balance = value;
        });
      },
      onSaved: (balance) => widget.coffeeData.setBalance = balance,
    );
  }

  //Desc
  Widget descField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 10,
      decoration:
          InputDecoration(labelText: "description", hintText: '설명을 입력해주세요'),
      validator: (country) {
        if (country.isEmpty) {
          return '설명을 입력해주세요.';
        }
        return null;
      },
      initialValue: widget.coffeeData.desc,
      onSaved: (country) => widget.coffeeData.setDesc = country,
    );
  }

  //Image
  Widget imageField() {
    _profileImageURL = widget.coffeeData.image;
    print("_profileImageURL###########" + _profileImageURL);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundImage:
                (_profileImageURL != null && _profileImageURL != "")
                    ? NetworkImage(_profileImageURL)
                    : ExactAssetImage('assets/camera.png'),
            radius: 30,
          ),
        ),
        RaisedButton(
          color: Colors.lightBlue,
          child: Text("Gallery"),
          onPressed: () {
            handleUploadType('gallery');
          },
        ),
        RaisedButton(
          color: Colors.lightBlue,
          child: Text("Camera"),
          onPressed: () {
            handleUploadType('camera');
          },
        )
      ],
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

    Reference storageReference =
        _firebaseStorage.ref().child("coffeebaseimage/$newFileName");

    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 30),
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

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
      widget.coffeeData.image = downloadURL;
    });

    //업로드가 끝나고도 화면에 사진이 보이는 시간이 좀 걸리기 때문에 추가 시간이 필요하다.
    await new Future.delayed(const Duration(seconds: 3));
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }

  // 문서 생성 (Create)
  void createDoc() {
    FirebaseFirestore.instance
        .collection(widget.coffeeData.colName)
        .add(widget.coffeeData.toMap());
    // .then((value) => Navigator.pop(context));
  }

  void updateDoc() {
    FirebaseFirestore.instance
        .collection(widget.coffeeData.colName)
        .doc(widget.documentID)
        .update(widget.coffeeData.toMap());
  }

  void deleteDoc() {
    FirebaseFirestore.instance
        .collection(widget.coffeeData.colName)
        .doc(widget.documentID)
        .delete();
  }

  showPasswordFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text("비밀번호가 서로 다릅니다."),
        action: SnackBarAction(
          label: "OK",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}
