import 'package:flutter/material.dart';
import 'package:coffeedic/provider/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/screens/login/signin_page.dart';
import 'package:coffeedic/screens/login/signedin_page.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d("user: ${fp.getUser()}");
    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
      return SignedInPage();
    } else {
      return SignInPage();
    }
  }
}
