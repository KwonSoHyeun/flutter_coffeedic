//  void showAlertDialog(BuildContext context) async {
//     String result = await showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('취향 저장'),
//           content: Text("커피 취향이 저장되었습니다."),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.pop(context, "OK");
//               },
//             ),
//             // FlatButton(
//             //   child: Text('Cancel'),
//             //   onPressed: () {
//             //     Navigator.pop(context, "Cancel");
//             //   },
//             // ),
//           ],
//         );
//       },
//     );
//   }
