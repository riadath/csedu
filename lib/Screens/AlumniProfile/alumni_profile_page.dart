import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/Screens/AlumniProfile/add_alumni_profile.dart';
import 'package:csedu/Screens/AlumniProfile/show_alumni_profile.dart';
import 'package:csedu/alumni_model.dart';
import 'package:csedu/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlumniProfilePage extends StatefulWidget {
  const AlumniProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AlumniProfilePage> createState() => _AlumniProfilePageState();
}

class _AlumniProfilePageState extends State<AlumniProfilePage> {
  Icon tIcon = const Icon(Icons.search);
  Widget searchBar = const Text('');
  final searchbarController = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'alumni profile page',
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
                        hintText: 'Name/Blood Group',
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
        body: StreamBuilder<List<AlumniModel>>(
          stream: readUsersSearch(searchbarController.text),
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
        floatingActionButton: Visibility(
          visible: FirebaseAuth.instance.currentUser!.email ==
              'chowdhuryittehad@gmail.com'
              ? true
              : false,
          child: FloatingActionButton.extended(
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAlumniProfile(),
                    ));
            },
            backgroundColor: gPrimaryColor,
            foregroundColor: gPrimaryColorDark,
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ),
      ),
    );
  }

  Stream<List<AlumniModel>> readUsersSearch(String search) {
    return FirebaseFirestore.instance.collection('alumni').orderBy('batch').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => AlumniModel.fromJson(doc.data()))
            .where((element) =>
                element.name.toLowerCase().contains(search.toLowerCase()) ||
                element.bloodGroup.toLowerCase().contains(search.toLowerCase()))
            .toList());
  }

  Widget buildUser(AlumniModel user) => Card(
        margin: const EdgeInsets.all(5),
        shadowColor: Colors.lime,
        color: Colors.grey[300],
        child: ListTile(
          leading: CircleAvatar(child: Text('${user.batch}')),
          trailing: CircleAvatar(child: Text('${user.bloodGroup}')),
          title: Text(user.name),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileCardAlumni(
                    name: user.name,
                    email: user.email,
                    batch: user.batch.toString(),
                    bloodGroup: user.bloodGroup,
                    linkedin: user.linkedin,
                  ),
                ));
          },
          // subtitle: Text(user.linkedin),
        ),
      );
}
