import 'package:csedu/Routine/routineInit.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';

import '../../StudyMaterials/study_materials_page.dart';
String? dashUid;

class DashboardOptions extends StatelessWidget {
  const DashboardOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 50),
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
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentProfilePage(),
                  ));
            },
          ),
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/graduated.png',
            title: 'Alumni Profiles',
            onPress: () {}
          ),
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/class_routine.png',
            title: 'Class Routine',
            onPress: ()  {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  RoutineInit(),
                  ));
              },

          ),
          CardCreator(
            screenSize: screenSize,
            imageUrl: 'images/study_materials.png',
            title: 'Study Materials',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Study_Material_Home(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class CardCreator extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onPress;
  const CardCreator({
    Key? key,
    required this.screenSize,
    required this.imageUrl,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
          color: Color.fromARGB(255, 194, 193, 193),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: screenSize.height * 0.14,
                  child: Image.asset(imageUrl)),
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
