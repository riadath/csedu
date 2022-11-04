import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Routine/classroom.dart';
import 'package:intl/intl.dart';
import 'package:csedu/Constants.dart';

import '../../rounded_input_field.dart';
import '../Screens/Home/navigation_drawer.dart';

class classAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _classAdd();

  String dropDownValue = 'Select Days';
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

    return MaterialApp(

      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

      home: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: gPrimaryColorDark),
          backgroundColor: gPrimaryColor,
          title:
          const Text("Add A class", style: TextStyle(color: gPrimaryColorDark)),
          actions: [
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(
                Icons.logout,
                color: gPrimaryColorDark,
              ),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('images/background_wave.jpg'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children:  <Widget>[
                  SizedBox(height: screenSize.height*.008),
                  RoundedInputField(
                    controller: courseNameController,
                    hintText: 'Course Code : CSE-1101',
                    icon: Icons.class_,
                    onChagned: (value) {},
                  ),
                  SizedBox(height: screenSize.height*.01),
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
                          onPressed: () async {
                            TimeOfDay time = TimeOfDay.now();
                            time = (await showTimePicker(context: context, initialTime: time))!;
                            startTime = time.format(context);
                            setState(() {

                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gPrimaryColor,
                            fixedSize: Size(100, 15),
                          ),
                          child: Text(startTime, style: const TextStyle(color: gPrimaryColorDark),)
                      ),
                      SizedBox(width: screenSize.width*.10),
                      ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? time = TimeOfDay.now();
                            time = (await showTimePicker(context: context, initialTime: time))!;
                            endTime = time.format(context);
                            setState(() {

                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gPrimaryColor,
                            fixedSize: const Size(100, 15),
                          ),
                          child: Text(endTime, style: const TextStyle(color: gPrimaryColorDark),)
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _showMultiSelect,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gPrimaryColor,
                      fixedSize: const Size(150, 15),
                    ),
                    child: const Text('Select Days', style: TextStyle(color: gPrimaryColorDark),),
                  ),
                  ElevatedButton(
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gPrimaryColor,
                      fixedSize: const Size(10, 15),
                    ),
                    child: const Text('Add', style: TextStyle(color: gPrimaryColorDark)),
                  ),
                ],
              ),
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