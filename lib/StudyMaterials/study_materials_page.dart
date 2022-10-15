import 'package:csedu/StudyMaterials/study_material_drawer.dart';
import 'package:flutter/material.dart';

class Study_Material_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Materials'),
        centerTitle: true,
        backgroundColor: Colors.red[800],
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Main screen',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
