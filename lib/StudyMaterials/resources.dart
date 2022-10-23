import 'package:csedu/StudyMaterials/pdf_viewer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class Resources{

  String str;
  Resources(this.str);

  Widget resources() => Column(
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
                            return pdfviewer(str+'/Resources/');
                          }
                      ));
                },
                child: const SizedBox(
                  width: 400,
                  height: 100,
                  child: Center( child: Text('Resources',style: TextStyle( color:Colors.white )) ),
                ),
              ),
            ),
          )
      ),
    ],
  );
}