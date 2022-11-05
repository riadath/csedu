import 'dart:async';

import 'package:csedu/Constants.dart';
import 'package:csedu/Screens/Login/login_screen.dart';
import 'package:csedu/Screens/Welcome/welcome_screen.dart';
import 'package:csedu/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isVerified = false;
  bool canResend = false;
  Timer? timer;

  @override
  void initState() {
    var tt = FirebaseAuth.instance.currentUser!;
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(tt);
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 2), (_) => checkEmailVerified());
    }
    super.initState();
  }

  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResend = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResend = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isVerified)
        ? const LoginScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Verify Email'),
              backgroundColor: gPrimaryColor,
              foregroundColor: gPrimaryColorDark,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(
                  'Click the link in the email to verify.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                RoundedButton(
                  buttonText: 'Resend Email',
                  textColor: gPrimaryColorDark,
                  onPress: () => canResend ? sendVerificationEmail() : null,
                )
              ],
            )),
          );
  }
}
