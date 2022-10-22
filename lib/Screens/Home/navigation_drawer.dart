import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/StudentProfiles/add_profile_page.dart';
import 'package:csedu/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String batchHintText = 'Batch';
String bloodHintText = "Blood Group";
String linkedinHintText = "LinkedIn";
String myButtonText = "Add Profile";

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  Widget buildNavbarItems({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 0, 0, 0)),
        title: Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        onTap: onTap,
      ),
    );
  }

  void setInitial() {
    final CollectionReference _usersRef =
        FirebaseFirestore.instance.collection('users');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = _usersRef.doc(uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        bool flag = false;
        if (data['bloodGroup'] != "") {
          bloodHintText = data['bloodGroup'].toString();
          flag = true;
        } else {
          bloodHintText = 'Blood Group';
        }
        if (data['batch'] != 0) {
          batchHintText = data['batch'].toString();
          flag = true;
        } else {
          batchHintText = 'Batch';
        }
        if (data['linkedin'] != "") {
          linkedinHintText = data['linkedin'].toString();
          flag = true;
        } else {
          linkedinHintText = 'LinkedIn';
        }

        if (flag) {
          myButtonText = 'Update Profile';
        }
      },
      onError: (e) => print('Could not retrive data'),
    );
  }

  @override
  void initState() {
    setState(() {
      setInitial();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: gPrimaryColor,
      child: ListView(
        padding: const EdgeInsets.only(left: 30, top: 40),
        children: [
          // const SizedBox(height: 50),
          buildNavbarItems(
              icon: Icons.person,
              text: "Add Your Profile",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddProfileScreen(
                      batchnoht: batchHintText,
                      bloodht: bloodHintText,
                      linkedht: linkedinHintText,
                      buttonText: myButtonText,
                    );
                  },
                ));
              }),
          buildNavbarItems(
              icon: Icons.notifications, text: "Notifications", onTap: () {}),
          buildNavbarItems(
              icon: Icons.settings, text: "Settings", onTap: () {}),
          const SizedBox(height: 20),
          const Divider(
            color: gPrimaryColorLight,
            thickness: .8,
            endIndent: 20,
          ),
          const SizedBox(height: 20),
          buildNavbarItems(
              icon: Icons.help_center_sharp, text: "Help", onTap: () {}),
          buildNavbarItems(icon: Icons.call, text: "Conact Us", onTap: () {})
        ],
      ),
    );
  }
}
