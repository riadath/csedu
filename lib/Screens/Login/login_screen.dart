import 'package:csedu/Screens/Home/home_screen.dart';
import 'package:csedu/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/rounded_button.dart';
import '../../rounded_input_field.dart';
import '../../rounded_password_field.dart';
import '../../auth.dart';
import '../Signup/signup_screen.dart';

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
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('images/vectorWave3.jpg'),
              ),
            ),
          ),
          // TweenAnimationBuilder<double>(
          //   tween: Tween<double>(begin: 0.1, end: .94),
          //   duration: Duration(milliseconds: 200),
          //   builder: (context, scale, child) {
          //     return Transform.scale(scale: scale, child: child);
          //   },
          child,
          // ),
        ],
      ),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenSize.height * .02,
          ),
          Image.asset('images/ebook.png'),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Text(errorMessage,
              style: const TextStyle(
                color: Colors.red,
              )),
          RoundedInputField(
            controller: emailController,
            hintText: 'Email',
            icon: Icons.person,
            onChagned: (value) {},
          ),
          RoundedPasswordField(
            controller: passwordController,
            hintText: 'Password',
          ),
          RoundedButton(
            buttonText: 'Login',
            onPress: () {
              setState(() {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  errorMessage = 'Enter Email and Password';
                } else {
                  errorMessage = '';
                  _auth.signIn(emailController.text.trim(),
                      passwordController.text.trim());
                }
              });
            },
            textColor: gPrimaryColorDark,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account ? ',
                style: TextStyle(color: gPrimaryColorDark),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeWidget(),
                      ));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: gPrimaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                FirebaseAuth.instance.currentUser!.emailVerified) {
              return HomeScreen();
            } else {
              return LoginWidget();
            }
          }),
    );
  }
}
