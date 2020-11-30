import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:video/pages/signin.dart';

import 'package:camera/camera.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(colorScheme: ColorScheme.light()),
        debugShowCheckedModeBanner: false,
        home: SignIn());
  }
}
