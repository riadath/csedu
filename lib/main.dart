import 'package:flutter/material.dart';
import 'package:csedu/Screens/Welcome/welcomeScreen.dart';

const gPrimaryColor = Color.fromARGB(255, 207, 197, 48);
const gPrimaryColorLight = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

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
