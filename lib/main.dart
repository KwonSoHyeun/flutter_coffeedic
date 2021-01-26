import 'package:flutter/material.dart';
import 'package:coffeedic/screens/home/main_screen.dart';
import 'package:coffeedic/util/const.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/provider/firebase_auth_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ignore: missing_required_param
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: Constants.lightTheme,
        darkTheme: Constants.darkTheme,
        home: MainScreen(),
      ),
    );
  }
}
