import 'package:csedu/RoundedButton.dart';
import 'package:csedu/RoundedInputField.dart';
import 'package:csedu/RoundedPasswordField.dart';
import 'package:csedu/Screens/Home/HomeScreen.dart';
import 'package:csedu/Screens/Login/LoginScreen.dart';
import 'package:csedu/auth.dart';
import 'package:csedu/constants.dart';
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
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('error message here'),
            SizedBox(
              height: screenSize.height * 0.2,
            ),
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            RoundedInputField(
              hintText: 'First Name',
              icon: Icons.person,
              onChagned: (value) {},
              controller: firstNameController,
            ),
            RoundedInputField(
              hintText: 'Last Name',
              icon: Icons.person,
              onChagned: (value) {},
              controller: lastNameController,
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
            RoundedButton(
                buttonText: 'Sign Up',
                onPress: () async {
                  dynamic result = await _auth.registerWithEmailAndPassword(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (result == null) {
                    print('Could not register\n');
                  } else {
                    _auth.signIn(emailController.text.trim(),
                        passwordController.text.trim());
                    emailController.clear();
                    passwordController.clear();
                    switchScreen();
                  }
                },
                textColor: gPrimaryColorDark)
          ],
        ),
      ),
    );
  }

  void switchScreen() {
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
