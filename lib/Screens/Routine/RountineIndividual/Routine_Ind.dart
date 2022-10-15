import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Routine/Routine_page.dart';

class RoutineInd extends StatelessWidget {
  String name;
  String url;
  RoutineInd({super.key, required this.name, required this.url});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('images/routine_26.png'),
    );
  }
}

