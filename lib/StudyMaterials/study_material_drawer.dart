import 'package:flutter/material.dart';
import 'package:csedu/StudyMaterials/study_materials_tab_view.dart';

import '../Constants.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(27),
            color: gPrimaryColor,
            child: const Center(
              child: Text(
                'Semesters',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),
              ),
            ),
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('1-1', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(0),
                  ));
            },
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('1-2', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(1),
                  ));
            },
          ),
           ListTile(
            leading : Icon( Icons.school ),
            title: Text('2-1', style : TextStyle(fontSize : 18)),
             onTap : () {
               Navigator.of(context).pop();
               Navigator.of(context).pop();
               Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => StudyMaterialTabView(2),
                   ));
             },
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('2-2', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(3),
                  ));
            },
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('3-1', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(4),
                  ));
            },
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('3-2', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(5),
                  ));
            },
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('4-1', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(6),
                  ));
            },
          ),
          ListTile(
            leading : Icon( Icons.school ),
            title: Text('4-2', style : TextStyle(fontSize : 18)),
            onTap : () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialTabView(7),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
