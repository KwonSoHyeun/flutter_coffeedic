import 'package:coffeedic/language/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// final Map<String, String> helpMessage = {
//   'home': '검색창에 찾고 싶은 원두명을 입력해 보세요. \n 찾으시는 원두정보가 원두명을 기준으로 정렬되어 보여집니다.',
//   'homedetail':
//       '상세 원두 정보를 볼 수 있습니다. 원두의 생산지 정보와 향, 바디감, 단맛, 산미, 쓴맛, 발란스 정보등을 보여줍니다. \n 하트 모양을 눌러 좋아하는 원두를 저장할 수 있습니다. ',
//   'favorite': '내가 좋아하는 취향 설정을 한 후, 원두 목록을 눌러보세요.\n 내 취향에 맞는 원두 정보만을 볼수 있습니다.',
//   'heart': '상세 페이지에서 하트 모양을 눌러 좋아하는 원두를 저장하면, \n내가 고른 좋이하는 원두만 볼 수 있습니다.',
//   'login': '관리자 화면입니다. 일반 유저는 로그인 할 수 없습니다.',
// };

void showAlertDialogHelp(BuildContext context, String messageType) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("help"),
        //content: Text(helpMessage[messageType]),
        content: Text(Translations.of(context).trans(messageType)),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context, "OK");
            },
          ),
        ],
      );
    },
  );
}

void showAlertDialog(BuildContext context, String title, String message) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context, "OK");
            },
          ),
        ],
      );
    },
  );
}
