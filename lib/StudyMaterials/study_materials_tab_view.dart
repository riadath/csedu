import 'package:csedu/Screens/Routine/Routine_screen.dart';
import 'package:csedu/StudyMaterials/past_questions.dart';
import 'package:csedu/StudyMaterials/pdf_viewer_page.dart';
import 'package:csedu/StudyMaterials/resources.dart';
import 'package:csedu/StudyMaterials/study_material_drawer.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Home/home_screen.dart';

import '../Constants.dart';

class StudyMaterialTabView extends StatefulWidget {
  final int semesterNo;
  const StudyMaterialTabView(this.semesterNo );
  @override
  State<StudyMaterialTabView> createState() => _StudyMaterialTabViewState();

}

class _StudyMaterialTabViewState extends State<StudyMaterialTabView> {
  int currentIndex = 0;
  List<String> First = ['/Study Materials/1-1 Past Questions', '/Study Materials/1-2 Past Questions','/Study Materials/2-1 Past Questions','/Study Materials/2-1 Past Questions',
    '/Study Materials/3-1 Past Questions','/Study Materials/3-2 Past Questions','/Study Materials/4-1 Past Questions','/Study Materials/4-2 Past Questions'];
  List<String> Second = ['/Final','/In Course','/Resources'];


  @override
  Widget build(BuildContext context) {

    past_questions question = past_questions( First[widget.semesterNo] );
    Resources resources = Resources( First[widget.semesterNo] );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Materials'),
        centerTitle: true,
        backgroundColor: gPrimaryColor,
      ),
      drawer : MainDrawer(),
      body: currentIndex == 0 ? question.pastQuestions() : resources.resources(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: gPrimaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon( Icons.question_mark ),
            label: 'Past Questions',
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.book ),
            label: 'Resources',
          ),
        ],
      ),
    );
  }
}