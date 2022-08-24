import 'package:flutter/material.dart';
import 'package:csedu/Screens/Welcome/WelcomeWidget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WelcomeWidget());
  }
}
