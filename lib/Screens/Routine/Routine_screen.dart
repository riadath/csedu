import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/Screens/Routine/ClassAdd_page.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Routine/classroom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csedu/user_model.dart';
import 'package:csedu/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../StudentProfiles/show_user_profile.dart';

class RoutineByDay extends StatefulWidget {
  const RoutineByDay({Key? key}) : super(key: key);

  @override
  State<RoutineByDay> createState() => _RoutineByDay();
}

class _RoutineByDay extends State<RoutineByDay> {

  int day = DateTime.now().weekday;
  String curBatch = '26';
  DateTime date = DateTime.now().toLocal();
  final List<String> weekDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  @override
  Widget build(BuildContext context)  {
    Size screenSize = MediaQuery.of(context).size;
    String s = 'Cse-1101';
    print(s.toUpperCase());
    return MaterialApp(
      title: 'Routine',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Center(
              child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: screenSize.width*0.30,
                      child: ElevatedButton(
                          onPressed: () {
                            date = date.subtract(Duration(days:1));

                            setState(() {
                                    day = date.weekday;
                            });
                          },
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.arrow_back),
                              Text('Previous Day'),
                            ],
                          )
                      ),
                    ),
                    SizedBox(
                        width: screenSize.width*0.40,
                        child: Column(
                          children: <Widget>[
                            Text(weekDays[day - 1], textAlign: TextAlign.center, style: TextStyle(
                              fontSize: screenSize.height*0.03,
                            ),),
                            Text(DateFormat('dd-mm-yyyy').format(date)),
                          ],
                        )
                    ),
                    SizedBox(
                      width: screenSize.width*0.30,
                      child: ElevatedButton(
                          onPressed: () {
                            date = date.add(Duration(days:1));
                            setState(() {
                                day = date.weekday;
                                print(day);
                            });
                          },
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.arrow_forward),
                              Text('Next Day'),
                            ],
                          )
                      ),
                    )
                  ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Classroom>>(
                stream: readRoutine(),
                builder: ((context, snapshot) {
                  final cls = snapshot.data;
                  if (snapshot.hasError) {
                    return Text('Could not get data >>> ${snapshot.error}');
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
          ],
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
    child: routineCard(
      course: cls,
    ),
  );

}


class routineCard extends StatefulWidget{
  @override
  Classroom course;
  routineCard({super.key, required this.course});
  State<StatefulWidget> createState() => _routineCard(course: course);

}

const List<Widget> state = <Widget>[
  Text('Done'),
  Text('Missed'),
  Text('Skipped')
];
class _routineCard extends State<routineCard> {
  Classroom course;
  _routineCard({required this.course});
  final List<bool> _selected = <bool>[false, false, true];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      child: Card(
          color: const Color.fromARGB(255, 194, 193, 193),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(width: screenSize.width*0.30,
                      child: Column(
                        children: <Widget>[
                          ToggleButtons(
                              direction: Axis.vertical,
                            onPressed: (int index) {
                              setState(() {
                                // The button that is tapped is set to true, and the others to false.
                                for (int i = 0; i < _selected.length; i++) {
                                  _selected[i] = i == index;
                                }
                              });
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(0)),
                            selectedBorderColor: Colors.red[700],
                            selectedColor: Colors.black,
                            fillColor: Colors.red[500],
                            color: Colors.red[400],
                            constraints: const BoxConstraints(
                              minHeight: 30.0,
                              maxHeight: 30.0,
                              minWidth: 50,
                              maxWidth: 50,
                            ),
                            isSelected: _selected,
                            children: state,
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width*0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            course.courseName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            course.instructor,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width*0.31,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Start at : ${course.startTime}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'End at : ${course.endTime}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
            Padding(
                padding: EdgeInsets.all(10),
                child : LinearPercentIndicator(
                  animation: true,
                  percent: 0.7,
                  center: Text('.5%'),
                  lineHeight: 20,
                  progressColor: Colors.green,
                  backgroundColor: Colors.red,
                )
            )

            ],
            ),
          )),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

}