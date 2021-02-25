import 'package:flutter/material.dart';
import 'package:coffeedic/screens/home/main_screen.dart';
import 'package:coffeedic/util/const.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/provider/firebase_auth_provider.dart';
import 'package:coffeedic/services/firestore_service.dart';
//import 'package:coffeedic/provider/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:coffeedic/language/translations.dart';
import 'package:coffeedic/language/translations_delegate.dart';
import 'package:admob_flutter/admob_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Admob.initialize();
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
        StreamProvider(create: (context) {
          return firestoreService.getCoffees();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: Constants.lightTheme,
        darkTheme: Constants.darkTheme,
        home: MainScreen(),
        supportedLocales: [const Locale('ko', 'KR'), const Locale('en', 'US')],
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          if (locale == null) {
            debugPrint("*language locale is null!!!");
            return supportedLocales.first;
          }

          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              debugPrint("*language ok $supportedLocale");
              return supportedLocale;
            }
          }

          debugPrint("*language to fallback ${supportedLocales.first}");
          return supportedLocales.first;
        },
      ),
    );
  }
}
