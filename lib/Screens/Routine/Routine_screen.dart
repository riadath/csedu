import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/Screens/Routine/ClassAdd_page.dart';
import 'package:csedu/Screens/Routine/routineInit.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csedu/Screens/Routine/routineInit.dart';

List<bool> _selected = <bool>[false, false];
DateTime date = DateTime.now().toLocal();




class RoutineByDay extends StatefulWidget {
  const RoutineByDay({Key? key}) : super(key: key);

  @override
  State<RoutineByDay> createState() => _RoutineByDay();
}

class _RoutineByDay extends State<RoutineByDay> {

  int day = DateTime.now().weekday;
  String? curBatch = Batch;

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
                            date = date.subtract(const Duration(days:1));

                            setState(() {
                                    day = date.weekday;
                                    _selected = <bool>[false, false];
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
                            Text(DateFormat('dd-MM-yyyy').format(date)),
                          ],
                        )
                    ),
                    SizedBox(
                      width: screenSize.width*0.30,
                      child: ElevatedButton(
                          onPressed: () {
                            date = date.add(const Duration(days:1));
                            setState(() {
                                day = date.weekday;
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
String percent = 'no data';

class routineCard extends StatefulWidget{
  Classroom course;
  routineCard({super.key, required this.course});
  @override
  State<StatefulWidget> createState() => _routineCard(course: course);

}

Map<String, List<bool>> attendance = {};
class _routineCard extends State<routineCard> {
  Classroom course;
  _routineCard({required this.course});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String Date = DateFormat('dd-MM-yyyy').format(date);
    String id = '$Date - ${course.courseName}';
    List<bool>? list = [false, false];
    if(attendance[id] != null) {
      list = attendance[id];
      //print(attendance[id]);
    }
    // print('on top');
    //print(list);
    // print(id);
    List checkList = [
      {
        "id" : 0,
        "value" : list?[0],
        "title" : 'Done',
      },
      {
        "id" : 1,
        "value" : list?[1],
        "title" : 'Missed',
      }
    ];
    return GestureDetector(
      child: Card(
          color: const Color.fromARGB(255, 194, 193, 193),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(width: screenSize.width*0.32,
                      child: Column(
                        children: List.generate(
                          checkList.length,
                            (index) => CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                                dense: true,
                                title: Text(checkList[index]['title']),
                                value: checkList[index]['value'],
                                onChanged: (value){
                                  setState(() {
                                    for(var element in checkList!){
                                      element['value'] = false;
                                    }
                                    checkList[index]['value'] = value;
                                    attendance[id] = [checkList[0]['value'], checkList[1]['value']];

                                    // print('on bottom');
                                    // print(attendance[id]);
                                    // print(checkList);
                                  });
                                }
                            )
                        )
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width*0.28,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${course.courseName} - ${course.batch}' ,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            course.instructor,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width*0.25,
                      child: Column(
                        children: <Widget>[
                          Text(
                            course.startTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lucida Console',
                              fontSize: 15,
                            ),
                          ),
                          Text('to'),
                          Text(
                            course.endTime,
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
                padding: const EdgeInsets.all(10),
                child : LinearPercentIndicator(
                  animation: true,
                  percent: calc(course.courseName),
                  center: Text(percent),
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

double calc(String course){
  int tot = 0, attend = 0;
  attendance.forEach((key, value) {
    if(key.contains(course)){
      tot++;
      if(value[0]) attend++;
    }
  });
  if(tot == 0){
    percent = 'no data';
    return 1;
  }
  double res = attend/tot;

  percent = '${(res*100).toStringAsFixed(0)}%';

  return res;
}


