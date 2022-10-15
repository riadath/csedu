import 'package:csedu/Screens/Routine/RountineIndividual/Routine_Ind.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';

class RoutinesAllBatch extends StatelessWidget {
  const RoutinesAllBatch({
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
            title: '27',
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
            title: '26',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  RoutineInd(name: '26', url: 'images/routine_26.png'),
                  ));
            },
          ),
          CardCreator(
            screenSize: screenSize,
            title: '25',
            onPress: () {},
          ),
          CardCreator(
            screenSize: screenSize,
            title: '24',
            onPress: () {},
          ),
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
