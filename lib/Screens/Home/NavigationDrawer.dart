import 'package:csedu/constants.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: gPrimaryColor,
      child: ListView(
        padding: EdgeInsets.only(left: 30, top: 40),
        children: [
          // const SizedBox(height: 50),
          buildNavbarItems(icon: Icons.person, text: "Profile", onTap: () {}),
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
