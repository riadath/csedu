import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csedu/Screens/Routine/Routine_page.dart';
import 'package:flutter/material.dart';


String Batch = '27';



class RoutineInit extends StatelessWidget{
  const RoutineInit({super.key});
  @override
  StatefulWidget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String uid = FirebaseAuth.instance.currentUser!.uid;
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
          return RoutineWidget();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
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
    onError: (e) => print('Could not retrive data'),
  );
  return ret;
}
