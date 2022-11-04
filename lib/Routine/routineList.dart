import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Routine/routineInit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'Routine_screen.dart';
import 'classroom.dart';
import 'package:intl/intl.dart';


class RoutineList extends StatelessWidget{
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
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
    );
  }

}

Stream<List<Classroom>> readRoutine() {

  return FirebaseFirestore.instance
      .collection('routines')
      .orderBy('startTime')
      .where('batch', isEqualTo: Batch)
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
          color: const Color.fromARGB(255, 194, 193, 193),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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