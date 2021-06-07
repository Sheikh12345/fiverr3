import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'screens/splash.dart';
import 'package:deto/screens/launch_screen.dart';
import 'package:deto/screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'package:deto/screens/forgot_password.dart';
// import 'package:deto/screens/bookmarks.dart';
// import 'package:deto/screens/calendar_view.dart';
// import 'package:deto/screens/add_event.dart';
// import 'package:deto/screens/settings.dart';
import 'package:deto/screens/about.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
            appId: '1:29388491207:ios:056dd28a6ac44be8ed71e2',
            apiKey: 'AIzaSyC8SAGzkTCPMYyO4DqUZhatBbYqpsHOTSs',
            projectId: 'deto-app',
            messagingSenderId: '29388491207',
            databaseURL: 'https://deto-app-default-rtdb.europe-west1.firebasedatabase.app',
          )
        : const FirebaseOptions(
            appId: '1:29388491207:android:01d97b9033eda6fbed71e2',
            apiKey: 'AIzaSyC8SAGzkTCPMYyO4DqUZhatBbYqpsHOTSs',
            messagingSenderId: '29388491207',
            projectId: 'deto-app',
            databaseURL: 'https://deto-app-default-rtdb.europe-west1.firebasedatabase.app',
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Splash.id,
        routes: {
          Splash.id: (context) => Splash(),
          Launch.id:(context)=>Launch(),
          Home.id:(context)=>Home(),
          Login.id: (context) => Login(),
          SignUp.id: (context) => SignUp(),
          ForgotPassword.id:(context)=>ForgotPassword(),
          About.id:(context)=>About(),
        }
        );
  }
}
