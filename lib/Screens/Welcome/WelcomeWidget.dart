import 'package:csedu/Screens/Login/LoginScreen.dart';
import 'package:csedu/Screens/Signup/SignupScreen.dart';
import 'package:flutter/material.dart';
import '../../RoundedButton.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

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
          // Positioned(
          //   top: 44,
          //   right: 0,
          //   child: RotationTransition(
          //     turns: AlwaysStoppedAnimation(15 / 360),
          //     child: Image.asset(
          //       'images/readingbook.png',
          //       width: screenSize.width * .3,
          //     ),
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}
