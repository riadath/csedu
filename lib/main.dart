import 'package:csedu/Constants.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Welcome/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSEDU',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
