import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Home/home_screen.dart';
import 'package:csedu/Screens/Login/login_screen.dart';
import 'package:csedu/Screens/Signup/signup_screen.dart';
import '../../rounded_button.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: screenSize.height * 0.0),
            SizedBox(
              width: screenSize.width * .1,
              height: screenSize.height * .1,
              child: Image.asset('images/csedu.jpg'),
            ),
            SizedBox(
              height: screenSize.height * .04,
            ),
            Image.asset('images/learn.png', height: screenSize.height * .4),
            RoundedButton(
              buttonText: 'Login',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              textColor: Colors.black,
            ),
            RoundedButton(
              buttonText: 'Signup',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ));
              },
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                FirebaseAuth.instance.currentUser!.emailVerified) {
              return const HomeScreen();
            } else {
              return const WelcomeWidget();
            }
          }),
    );
  }
}
