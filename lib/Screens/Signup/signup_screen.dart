import 'package:csedu/rounded_button.dart';
import 'package:csedu/rounded_input_field.dart';
import 'package:csedu/rounded_password_field.dart';
import 'package:csedu/Screens/Home/home_screen.dart';
import 'package:csedu/Screens/Login/login_screen.dart';
import 'package:csedu/auth.dart';
import 'package:csedu/Constants.dart';
import 'package:flutter/material.dart';

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
                image: AssetImage('images/vectorWave0.jpg'),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screenSize.height * 0.1),
          Text(errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
              )),
          SizedBox(height: screenSize.height * 0.1),
          const Text(
            'Create Account',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          RoundedInputField(
            hintText: 'Name',
            icon: Icons.person,
            onChagned: (value) {},
            controller: nameController,
          ),
          RoundedInputField(
            hintText: 'Email',
            icon: Icons.email,
            onChagned: (value) {},
            controller: emailController,
          ),
          RoundedPasswordField(
            controller: passwordController,
            hintText: 'Password',
          ),
          RoundedPasswordField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
          ),
          SizedBox(height: screenSize.height * 0.1),
          RoundedButton(
              buttonText: 'Sign Up',
              onPress: () async {
                bool if_valid = validateInputs();
                if (!if_valid) {
                  setState(() {});
                }
                dynamic result = await _auth.registerWithEmailAndPassword(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  nameController.text,
                );
                if (result == null) {
                  errorMessage =
                      'Could not register. Invalid Email/Email already registered';
                  setState(() {});
                } else {
                  switchScreen();
                }
              },
              textColor: gPrimaryColorDark)
        ],
      ),
    );
  }

  bool validateInputs() {
    if (nameController.text.isEmpty) {
      errorMessage = 'Name Field is Empty';
      return false;
    } else if (emailController.text.isEmpty) {
      errorMessage = 'Email Field is Empty';
      return false;
    } else if (passwordController.text.isEmpty) {
      errorMessage = 'Password Field is Empty';
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      errorMessage = 'Confirm Password Field is Empty';
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      errorMessage = 'Confirm Password Missmatch';
      return false;
    }
    return true;
  }

  void switchScreen() {
    _auth.signIn(emailController.text.trim(), passwordController.text.trim());
    emailController.clear();
    passwordController.clear();
    Navigator.pop(context);
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SignupWidget(),
        ));
  }
}
