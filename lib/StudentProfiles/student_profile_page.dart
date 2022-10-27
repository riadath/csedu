import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/StudentProfiles/show_user_profile.dart';
import 'package:csedu/rounded_input_field.dart';
import 'package:csedu/user_model.dart';
import 'package:flutter/material.dart';

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
  Icon tIcon = const Icon(Icons.search);
  Widget searchBar = const Text('');
  final searchbarController = TextEditingController();
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
          backgroundColor: gPrimaryColor,
          foregroundColor: gPrimaryColorDark,
          actions: <Widget>[
            searchBar,
            IconButton(
              onPressed: () {
                setState(() {
                  if (tIcon.icon == Icons.search) {
                    tIcon = const Icon(Icons.cancel);
                    searchBar = RoundedInputField(
                        hintText: 'Search',
                        icon: Icons.search,
                        onChagned: (value) {
                          setState(() {});
                        },
                        controller: searchbarController);
                  } else {
                    tIcon = const Icon(Icons.search);
                    searchBar = const Text('');
                    searchbarController.clear();
                  }
                });
              },
              icon: tIcon,
            )
          ],
        ),
        body: StreamBuilder<List<UserModel>>(
          stream: readUsersSearch(widget.batch, searchbarController.text),
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

  Stream<List<UserModel>> readUsersSearch(int batch, String search) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('showData', isEqualTo: true)
        .where('batch', isEqualTo: batch)
        .orderBy('roll')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .where((element) =>
                element.name.toLowerCase().contains(search.toLowerCase()))
            .toList());
  }

  Widget buildUser(UserModel user) => Card(
        margin: const EdgeInsets.all(5),
        shadowColor: Colors.lime,
        color: Colors.grey[300],
        child: ListTile(
          leading: CircleAvatar(child: Text('${user.roll}')),
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
                    roll: user.roll.toString(),
                  ),
                ));
          },
          // subtitle: Text(user.linkedin),
        ),
      );
}
