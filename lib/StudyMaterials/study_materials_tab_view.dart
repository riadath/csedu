import 'package:flutter/material.dart';

class StudyMaterialTabView extends StatelessWidget {
  const StudyMaterialTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Materials'),
        centerTitle: true,
        backgroundColor: Colors.red[800],
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon( Icons.question_mark ),
            label: 'Past Questions',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.book ),
            label: 'Resources',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
