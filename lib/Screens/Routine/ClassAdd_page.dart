import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Routine/classroom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csedu/rounded_button.dart';
import 'package:intl/intl.dart';

import '../../rounded_input_field.dart';

class classAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _classAdd();

  String dropdownvalue = 'Select Days';

  // List of items in our dropdown menu

}

class _classAdd extends State<classAdd> {
  final courseNameController = TextEditingController();
  final instructorNameController = TextEditingController();
  final batchController = TextEditingController();
  String startTime = 'start at';
  String endTime = 'end at';
  String errorPrompt = 'e';

  List<String> _selectedItems = [];
  Map<String, int> weekDay = {
  'Sunday' : 7,
  'Monday' : 1,
  'Tuesday' : 2,
  'Wednesday' : 3,
  'Thursday' : 4,
  'Friday' : 5,
  'Saturday' : 6,
  };

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(title: const Text('Add A class'),),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children:  <Widget>[
            const SizedBox(height: 20),
            RoundedInputField(
              controller: courseNameController,
              hintText: 'Course Code',
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
                        startTime = time.format(context);
                        print(startTime);

                    },
                ),
                const SizedBox(width: 30,),
                ElevatedButton(
                  child: Text(endTime),
                  onPressed: () async {
                    TimeOfDay? time = TimeOfDay.now();
                    time = (await showTimePicker(context: context, initialTime: time))!;
                    endTime = time.format(context);

                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _showMultiSelect,
              child: const Text('Select Days'),
            ),
            ElevatedButton(
              child: const Text('Add'),
                onPressed: () {
                  if(courseNameController.text.isEmpty){
                    errorPrompt = 'Course name cannot be empty';
                    showAlert('class could''t be created!', errorPrompt, context);
                    print(errorPrompt);
                  }
                  else if(instructorNameController.text.isEmpty){
                    errorPrompt = 'instructor name cannot be empty';
                    showAlert('class could''t be created!', errorPrompt, context);
                  }
                  else if(batchController.text.isEmpty){
                    errorPrompt = 'Batch number cannot be empty';
                    showAlert('class could''t be created!', errorPrompt, context);
                  }
                  else if(_selectedItems.isEmpty){
                    errorPrompt = 'Select  at least one day';
                    showAlert('class could''t be created!', errorPrompt, context);
                  }
                  else if(startTime == 'start at' || endTime == 'end at' || !getTime(startTime, endTime)){
                    errorPrompt = 'Invalid time';
                    showAlert('class could''t be created!', errorPrompt, context);
                  }
                  else{

                    _selectedItems.forEach((element)
                    {
                        Classroom cls = Classroom(courseName: courseNameController.text.trim().toUpperCase(), instructor: instructorNameController.text.trim().toUpperCase(),
                        batch: batchController.text.trim(), startTime: startTime!, endTime: endTime!, day: weekDay[element]!);

                        FirebaseFirestore.instance.collection('routines').add(cls.toJson());
                    });
                    errorPrompt = 'Class have been added successfully!';
                    showAlert(errorPrompt, '', context);


                  }

                }
            ),
          ],
        ),
      ),
    );
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item, isChecked!),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }


}
void showAlert(String title, String text, BuildContext context){
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

getTime(String st, String end) {
  bool result = false;
  TimeOfDay t1 = stringToTimeOfDay(st);
  TimeOfDay t2 = stringToTimeOfDay(end);
  int startTimeInt = (t1.hour * 60 + t2.minute) * 60;
  int EndTimeInt = (t2.hour * 60 + t2.minute) * 60;
  if(st[st.length - 2] == 'P') startTimeInt += 12*60;
  if(end[end.length - 2] == 'P') EndTimeInt += 12*60;
  int dif = EndTimeInt - startTimeInt;
  print(startTimeInt);
  print(EndTimeInt);
  if (EndTimeInt > startTimeInt) {
    result = true;
  } else {
    result = false;
  }
  return result;
}