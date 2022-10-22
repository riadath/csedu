import 'package:csedu/Screens/Routine/RountineIndividual/Routine_Ind.dart';
import 'package:csedu/Screens/Routine/RountineIndividual/Routine_pageInd.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Routine/classroom.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutinesAllBatch extends StatelessWidget {

  List<Classroom> list = <Classroom>[];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    list.add(Classroom(courseName: 'CSE-1001', instructor: 'MRR', starTime: '8:30 PM', endTime: '10:00 PM'));
    list.add(Classroom(courseName: 'CSE-1002', instructor: 'MIB', starTime: '10:00 PM', endTime: '11:30 PM'));
    list.add(Classroom(courseName: 'CSE-1002', instructor: 'MIB', starTime: '10:00 PM', endTime: '11:30 PM'));
    list.add(Classroom(courseName: 'CSE-1002', instructor: 'MIB', starTime: '10:00 PM', endTime: '11:30 PM'));
    list.add(Classroom(courseName: 'CSE-1002', instructor: 'MIB', starTime: '10:00 PM', endTime: '11:30 PM'));
    list.add(Classroom(courseName: 'CSE-1002', instructor: 'MIB', starTime: '10:00 PM', endTime: '11:30 PM'));
    list.add(Classroom(courseName: 'CSE-1002', instructor: 'MIB', starTime: '10:00 PM', endTime: '11:30 PM'));
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.red[200 + 200*(index%2)],
                        height: 150,
                        child: Column(
                          children: <Widget>[
                            Text(
                              list[index].courseName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                                list[index].instructor,
                                style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                    'Start Time : ${list[index].starTime}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                    'End Time : ${list[index].endTime}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  childCount: list.length,
              ),
          )
        ],
      ),

    );
  }
}

class CardCreator extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const CardCreator({
    Key? key,
    required this.screenSize,
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
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lucida Console',
                    fontSize: 50,

                  ),
                ),
              ),
            ],
          )),
    );
  }
}
