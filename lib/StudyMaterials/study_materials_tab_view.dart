import 'package:csedu/StudyMaterials/study_material_drawer.dart';
import 'package:flutter/material.dart';

class StudyMaterialTabView extends StatefulWidget {
  const StudyMaterialTabView({Key? key}) : super(key: key);

  @override
  State<StudyMaterialTabView> createState() => _StudyMaterialTabViewState();
}

class _StudyMaterialTabViewState extends State<StudyMaterialTabView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Materials'),
        centerTitle: true,
        backgroundColor: Colors.red[800],
      ),
      drawer : MainDrawer(),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon( Icons.question_mark ),
            label: 'Past Questions',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.book ),
            label: 'Resources',
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}