import 'package:csedu/Constants.dart';
import 'package:csedu/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../RoundedInputField.dart';
import '../Signup/SignupScreen.dart';

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
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'images/main_top.png',
                width: screenSize.width * .4,
              ),
            ),
            child,
          ],
        ));
  }
}

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _ifObscureText = true;

  void _toggleShowPassword() {
    setState(() {
      _ifObscureText = !_ifObscureText;
      // print(_ifObscureText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: _ifObscureText,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: gPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: (_ifObscureText)
                ? const Icon(Icons.remove_red_eye, color: gPrimaryColor)
                : const Icon(
                    Icons.remove_red_eye_outlined,
                    color: gPrimaryColor,
                  ),
            onPressed: _toggleShowPassword,
          ),
          hintText: 'Password',
          border: InputBorder.none,
        ),
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            height: screenSize.height * .1,
          ),
          Image.asset('images/ebook.png'),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          RoundedInputField(
            controller: emailController,
            hintText: 'Email',
            icon: Icons.person,
            onChagned: (value) {},
          ),
          RoundedPasswordField(
            controller: passwordController,
          ),
          RoundedButton(
            buttonText: 'Login',
            onPress: signIn,
            textColor: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account ? ',
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
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

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
