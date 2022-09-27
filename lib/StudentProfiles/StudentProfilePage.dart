import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/RoundedInputField.dart';
import 'package:csedu/constants.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    final t_controller = TextEditingController();
    return MaterialApp(
      title: 'student profile page',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            title: RoundedInputField(
              hintText: '',
              icon: Icons.near_me,
              onChagned: (value) {},
              controller: t_controller,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  createUser(name: t_controller.text);
                },
                icon: const Icon(
                  Icons.add,
                  color: gPrimaryColorDark,
                ),
              ),
            ],
          ),
          body: StreamBuilder<List<User>>(
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
      ),
    );
  }

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = User(
      id: docUser.id,
      name: name,
      batch: 56,
      linkedIn: 'bd.linkedin.com',
    );
    final json = user.toJson();
    await docUser.set(json);
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text('${user.batch}')),
        title: Text(user.name),
        subtitle: Text(user.linkedIn),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}



class User {
  String id;
  final String name;
  final int? batch;
  final String linkedIn;

  User({
    this.id = '',
    required this.name,
    required this.batch,
    required this.linkedIn,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'batch': batch,
        'linkedIn': linkedIn,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        batch: json['batch'],
        linkedIn: json['linkedIn'],
      );
}
