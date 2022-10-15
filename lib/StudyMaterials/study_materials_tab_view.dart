import 'package:csedu/StudyMaterials/study_material_drawer.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class StudyMaterialTabView extends StatefulWidget {
  final int semesterNo;
  const StudyMaterialTabView(this.semesterNo );

  @override
  State<StudyMaterialTabView> createState() => _StudyMaterialTabViewState();
}

class _StudyMaterialTabViewState extends State<StudyMaterialTabView> {
  int currentIndex = 0;
  final screens = [
    Center( child: Text('1-1 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('1-2 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('2-1 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('2-2 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('3-1 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('3-2 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('4-1 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('4-2 Questions',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('1-1 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('1-2 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('2-1 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('2-2 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('3-1 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('3-2 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('4-1 Resources',style: TextStyle( fontSize:60 )) ),
    Center( child: Text('4-2 Resources',style: TextStyle( fontSize:60 )) ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Materials'),
        centerTitle: true,
        backgroundColor: gPrimaryColor,
      ),
      drawer : MainDrawer(),
      body: screens[ widget.semesterNo+(8*currentIndex) ],
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