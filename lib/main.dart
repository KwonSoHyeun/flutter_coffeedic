import 'package:flutter/material.dart';
import 'package:coffeedic/screens/home/main_screen.dart';
import 'package:coffeedic/util/const.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/provider/firebase_auth_provider.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:coffeedic/provider/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        // ignore: missing_required_param
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        //ChangeNotifierProvider(create: (context) => ProductProvider()),
        //StreamProvider(create: (context) => firestoreService.getProducts()),
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
