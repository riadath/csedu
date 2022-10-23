import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Routine/classroom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csedu/rounded_button.dart';

import '../../rounded_input_field.dart';

class classAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _classAdd();


}

class _classAdd extends State<classAdd> {
  final courseNameController = TextEditingController();
  final instructorNameController = TextEditingController();
  final batchController = TextEditingController();
  String startTime = 'start at';
  String endTime = 'ent at';
  String errorPrompt = 'e';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(title: Text('Add A class'),),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children:  <Widget>[
            const SizedBox(height: 20),
            RoundedInputField(
              controller: courseNameController,
              hintText: 'Cousrse Code',
              icon: Icons.class_,
              onChagned: (value) {},
            ),
            const SizedBox(width: 30,),
            RoundedInputField(
              controller: instructorNameController,
              hintText: 'Instructor Name (short form)',
              icon: Icons.person,
              onChagned: (value) {},
            ),
            RoundedInputField(
              controller: batchController,
              hintText: 'Batch',
              icon: Icons.people,
              onChagned: (value) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(startTime),
                    onPressed: () async {
                        TimeOfDay time = TimeOfDay.now();
                         time = (await showTimePicker(context: context, initialTime: time))!;
                         startTime = '${time.hour}:${time.minute}';
                         print(startTime);
                    },
                ),
                const SizedBox(width: 30,),
                ElevatedButton(
                  child: Text(endTime),
                  onPressed: () async {
                    TimeOfDay? time = TimeOfDay.now();
                    time = (await showTimePicker(context: context, initialTime: time))!;
                    endTime = '${time.hour}:${time.minute}';;
                    print(endTime);
                  },
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Add'),
                onPressed: () {
                  if(courseNameController.text.isEmpty){
                    errorPrompt = 'Course name cannot be empty';
                  }
                  else if(instructorNameController.text.isEmpty){
                    errorPrompt = 'instructor name cannot be empty';
                  }
                  else if(batchController.text.isEmpty){
                    errorPrompt = 'Batch number cannot be empty';
                  }
                  else{
                    Classroom cls = Classroom(courseName: courseNameController.text.trim(), instructor: instructorNameController.text.trim(),
                        batch: batchController.text.trim(), startTime: startTime!, endTime: endTime!, day: 2);
                    errorPrompt = 'Class added successfully!';
                    print(cls);

                    FirebaseFirestore.instance.collection('routines').add(cls.toJson());

                  }

                }
            ),
          ],
        ),
      ),
    );
  }
}
