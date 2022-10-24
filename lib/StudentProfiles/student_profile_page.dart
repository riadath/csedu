import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/StudentProfiles/show_user_profile.dart';
import 'package:csedu/user_model.dart';
import 'package:flutter/material.dart';

import '../Screens/Home/navigation_drawer.dart';

class StudentProfilePage extends StatefulWidget {
  final int batch;
  const StudentProfilePage({
    required this.batch,
    Key? key,
  }) : super(key: key);

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
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Student List'),
          backgroundColor: gPrimaryColor,
          foregroundColor: gPrimaryColorDark,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: StreamBuilder<List<UserModel>>(
          stream: readUsers(widget.batch),
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

  Stream<List<UserModel>> readUsers(int batch) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('showData', isEqualTo: true)
        .where('batch', isEqualTo: batch)
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileCard(
                    uid: user.uid,
                    name: user.name,
                    batch: user.batch.toString(),
                    bloodGroup: user.bloodGroup,
                    linkedin: user.linkedin,
                    email: user.email,
                  ),
                ));
          },
          // subtitle: Text(user.linkedin),
        ),
      );
}
