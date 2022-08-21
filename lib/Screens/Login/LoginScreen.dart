import 'package:flutter/material.dart';
import 'package:csedu/Screens/Login/Body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
