import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/constants.dart';
import 'package:csedu/user_model.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'student profile page',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student List'),
        ),
        body: StreamBuilder<List<UserModel>>(
          stream: readUsers(),
          builder: ((context, snapshot) {
            final users = snapshot.data;
            if (snapshot.hasError) {
              return Text('Could not get data >>> ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView(
                children: users!.map(buildUser).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Stream<List<UserModel>> readUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('showData', isEqualTo: false)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList());
  }

  Widget buildUser(UserModel user) => Card(
        margin: const EdgeInsets.all(5),
        shadowColor: Colors.lime,
        color: Colors.grey[300],
        child: ListTile(
          leading: CircleAvatar(child: Text('${user.batch}')),
          title: Text(user.name),
          onTap: () {},
          // subtitle: Text(user.linkedin),
        ),
      );
}
