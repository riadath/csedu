import 'package:csedu/StudyMaterials/pdf_viewer_page.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class past_questions{



  String str;
  past_questions(this.str);


  Widget pastQuestions () => Column(
    children: <Widget>[
      Center(
          child: Builder(
            builder: ( BuildContext context ) => Card(
              color: gPrimaryColor,
              margin: EdgeInsets.all(20),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return pdfviewer(str+'/Final/');
                        }
                      ));
                },
                child: const SizedBox(
                  width: 400,
                  height: 100,
                  child: Center( child: Text('Final Questions',style: TextStyle( color:Colors.white )) ),
                ),
              ),
            ),
          )
      ),
      Center(
          child: Builder(
            builder: ( BuildContext context ) => Card(
              color: gPrimaryColor,
              margin: EdgeInsets.all(20),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pdfviewer(str+'/In Course/'),
                      ));
                },
                child: const SizedBox(
                  width: 400,
                  height: 100,
                  child: Center( child: Text('In Course Questions',style: TextStyle( color:Colors.white )) ),
                ),
              ),
            ),
          )
      ),
    ],
  );
}
