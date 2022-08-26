import 'package:csedu/Constants.dart';
import 'package:csedu/RoundedButton.dart';
import 'package:csedu/Screens/Home/NavigationDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Signup/SignupScreen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: screenSize.height * .1,
              child: Image.asset('images/csedu.png')),
          SizedBox(
            height: screenSize.height * .7,
            width: screenSize.width,
            child: DashboardOptions(),
          ),
        ],
      ),
    );
  }
}

class DashboardOptions extends StatelessWidget {
  const DashboardOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 80,
        crossAxisCount: 2,
        children: <Widget>[
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/student.png',
            title: 'Student Profiles',
          ),
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/graduated.png',
            title: 'Alumni Profiles',
          ),
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/class_routine.png',
            title: 'Class Routine',
          ),
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/study_materials.png',
            title: 'Study Materials',
          ),
        ],
      ),
    );
  }
}

class CardCreator extends StatelessWidget {
  final String imageUrl;
  final String title;
  const CardCreator({
    Key? key,
    required this.screenSize,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            ));
      },
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: screenSize.height * 0.14, child: Image.asset(imageUrl)),
          Container(
            padding: const EdgeInsets.only(top: 17),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Lucida Console',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
