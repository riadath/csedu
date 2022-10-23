import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/Screens/Routine/ClassAdd_page.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Routine/classroom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csedu/Screens/Home/dashboard_options.dart';

import '../../StudentProfiles/show_user_profile.dart';

class RoutinesAllBatch extends StatefulWidget {
  const RoutinesAllBatch({Key? key}) : super(key: key);

  @override
  State<RoutinesAllBatch> createState() => _RoutinesAllBatch();
}

class _RoutinesAllBatch extends State<RoutinesAllBatch> {

  String curBatch = '26';
  int day = 2;

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      title: 'Routine',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        body: StreamBuilder<List<Classroom>>(
          stream: readRoutine(),
          builder: ((context, snapshot) {
            final cls = snapshot.data;
            if (snapshot.hasError) {
              return Text('Could not get data here >>> ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView(
                children: cls!.map(buildCls).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
  Stream<List<Classroom>> readRoutine() {

    return FirebaseFirestore.instance
        .collection('routines')
        .orderBy('startTime')
        .where('batch', isEqualTo: curBatch)
        .where('day', isEqualTo: day)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Classroom.fromJson(doc.data()))
        .toList());
  }

  Widget buildCls(Classroom cls) => Card(
    margin: const EdgeInsets.all(5),
    shadowColor: Colors.lime,
    color: Colors.grey[300],
    child: ListTile(
      leading: CircleAvatar(child: Text(cls.courseName)),
      title: Text(cls.instructor),
      onTap: () {

      },
      // subtitle: Text(user.linkedin),
    ),
  );

}
