import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Routine/Routine_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csedu/Routine/Routine_page.dart';
import 'package:flutter/material.dart';
import 'package:csedu/Screens/Home/dashboard_options.dart';
import 'package:csedu/Routine/Routine_screen.dart';
String Batch = '';
String? uid;


class RoutineInit extends StatelessWidget{
  const RoutineInit({super.key});
  @override
  StatefulWidget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    uid = FirebaseAuth.instance.currentUser!.uid;
    dashUid = uid;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return const Text('SomeThing Error');
        }
        if(snapshot.hasData && !snapshot.data!.exists){
          return const Text('No data');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          Batch = data['batch'].toString();

          if(Batch == ''){
            return const AlertDialog(title: Text("Please add your information to see routines"), shape: OutlineInputBorder(),);
          }
          return fun();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  static Future<void> save(String? id)
  async {

  }

}

String retBatch() {
  String ret = '';
  final CollectionReference _usersRef =
  FirebaseFirestore.instance.collection('users');
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final docRef = _usersRef.doc(uid);
  docRef.get().then(
        (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      ret = data['batch'].toString();
    },
    onError: (e) => print('Could not retrieve data'),
  );
  return ret;
}


class myClass {
  String id;
  List<String> list;
  myClass({required this.id, required this.list});

  Map<String, dynamic> toJson() => {
    'id': id,
    'mp': list,
  };
  static myClass fromJson(Map<String, dynamic> json) => myClass(
    id: json['id'],
    list: json['mp'],

  );

}


FutureBuilder fun()
{
  var ref = FirebaseFirestore.instance.collection('attendance');

  return FutureBuilder<DocumentSnapshot>(

      future: ref.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return const Text('SomeThing Error');
        }
        if(snapshot.hasData && !snapshot.data!.exists){
          return  RoutineWidget();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
          Map<String, dynamic> value = data?['list']; // <-- The value you want to retrieve.

          value.forEach((key, value) {
            attendance[key] = <bool>[value[0], value[1]];
          });
          return  RoutineWidget();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
  );
}