import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/Routine/ClassAdd_page.dart';
import 'package:csedu/Routine/routineInit.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Routine/classroom.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:csedu/Constants.dart';

DateTime date = DateTime.now().toLocal();

class RoutineByDay extends StatefulWidget {
  const RoutineByDay({Key? key}) : super(key: key);

  @override
  State<RoutineByDay> createState() => _RoutineByDay();
}
int cnt = 0;
class _RoutineByDay extends State<RoutineByDay> {

  @override


  int day = DateTime.now().toLocal().weekday;

  String? curBatch = Batch;

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  void initState(){
    super.initState();
    print('on screen');
  }
  @override
  void dispose(){
    super.dispose();
    FirebaseFirestore.instance.collection('attendance').doc(uid).set({'list' : attendance});
    date = DateTime.now().toLocal();
  }

  @override
  Widget build(BuildContext context)  {

    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routine',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('images/background_wave2.jpg'),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenSize.width*0.30,
                          child: DecoratedBox(

                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  date = date.subtract(const Duration(days:1));

                                  setState(() {
                                          day = date.weekday;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: gPrimaryColor,
                                  foregroundColor: gPrimaryColorDark,
                                ),
                                child: Column(
                                  children: const <Widget>[
                                    Icon(Icons.arrow_back),
                                    Text('Previous Day'),
                                  ],
                                )
                            ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            shape: BoxShape.rectangle,
                          ),
                          child: SizedBox(
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gPrimaryColor,
                                foregroundColor: gPrimaryColorDark,
                              ),
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
          ],
        ),

        // floatingActionButton: Visibility(
        //   visible: true,
        //   child: FloatingActionButton.extended(
        //     onPressed: ()  {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) =>  classAdd(),
        //           ));
        //     },
        //     backgroundColor: gPrimaryColor,
        //     foregroundColor: gPrimaryColorDark,
        //     icon: const Icon(Icons.add),
        //     label: const Text('Add'),
        //   ),
        // ),
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
  int cnt = 0;
  Widget buildCls(Classroom cls) => Card(
    margin: const EdgeInsets.all(5),
    shadowColor: Colors.lime,
    color: Colors.grey[300],
    child: routineCard(
      course: cls
    ),
  );

}
String percent = 'no data';
bool isAdmin = true;
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
    }
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
          color: Colors.amberAccent,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(width: screenSize.width*0.35,
                      child: Column(
                        children: List.generate(
                          checkList.length,
                            (index) => CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                                dense: true,
                                title: Text(checkList[index]['title'], style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lucida Console',

                                ),),
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
                            course.courseName,
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
                          const Text('to'),
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
              child: Row(
                children : [
                    SizedBox(
                      width: screenSize.width * .78,
                      child: LinearPercentIndicator(
                        animation: true,
                        percent: calc(course.courseName),
                        center: Text(percent),
                        lineHeight: 20,
                        progressColor: Colors.blueAccent,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  SizedBox(
                      width: screenSize.width * .07,
                      height: 40,
                      child: Visibility(
                        visible: isAdmin,
                        child: TextButton(
                            child: const Icon(Icons.delete, color: Colors.redAccent,),
                            onPressed: ()  {
                               delete(course);
                               setState(() {

                               });
                            }

                        ),
                      )
                  )
                  ],
              ),
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

  percent = '$attend/$tot ${(res*100).toStringAsFixed(0)}%';

  return res;
}


void delete(Classroom cls) {
  String ret = '';
  final  ref =
  FirebaseFirestore.instance.collection('routines').where('courseName', isEqualTo: cls.courseName)
      .where('startTime', isEqualTo: cls.startTime)
      .where('endTime', isEqualTo: cls.endTime)
      .where('batch', isEqualTo: cls.batch)
      .where('day', isEqualTo: cls.day).get();
  
  ref.then(
        (snapshot) {
          for(DocumentSnapshot ds in snapshot.docs){
            print(ds.reference.id);
            ds.reference.delete();
          }


    },
    onError: (e) => print('Could not retrieve data'),
  );

}