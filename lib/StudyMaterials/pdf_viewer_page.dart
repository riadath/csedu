import 'dart:async';
import 'dart:io';
import 'package:csedu/StudyMaterials/viewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String pr = 'gs://csedu-project.appspot.com/Study Materials/1-1 Past Questions/Final/1-1, 2011, Final.pdf';
  String str = '/Study Materials/1-1 Past Questions/Final/';
  Future<ListResult>? futureFiles;


  @override
  void initState(){
    super.initState();
    futureFiles = FirebaseStorage.instance.ref(str).listAll();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Download Files'),
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
          builder: (context,snapshot){
            if( snapshot.hasData ){
              final files = snapshot.data!.items;
              return ListView.builder(
                itemCount: files.length,
                itemBuilder:( context,index ){
                  final file = files[index];
                  print(str +  file.name);
                  return ListTile(
                    title:Text(file.name),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        String  st = await printUrl(str +  file.name);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(st),
                            ));

                        /*
                        final docUrl = await FirebaseStorage.instance
                            .ref()
                            .child(str+file.name)
                            .getDownloadURL();
                        final docFile = DefaultCacheManager().getSingleFile(docUrl);
                        pdfviewer(docFile); */
                      }
                    ),
                  );
                },
              );
            }
            else{
              return const Center(child: Text('Loading.....'));
            }
          },
      ),
  );

  Future<String> printUrl( String str ) async {
    final ref = FirebaseStorage.instance.ref().child(str);
    String url = (await ref.getDownloadURL()).toString();
    return url;
  }

}
