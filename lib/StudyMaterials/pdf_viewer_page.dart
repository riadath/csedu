import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:csedu/Constants.dart';
import 'package:csedu/StudyMaterials/viewer.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

double percent = -1;
int downloadIndex = -1;
CancelToken cancelToken = CancelToken as CancelToken;

class pdfviewer extends StatefulWidget {
  String str;
  pdfviewer(this.str);

  @override
  State<pdfviewer> createState() => _pdfviewer(str);
}

class _pdfviewer extends State<pdfviewer> {
  String str;
  _pdfviewer(this.str);
  Future<ListResult>? futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref(str).listAll();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: gPrimaryColor,
          title: const Text('PDFs'),
        ),
        body: RefreshIndicator(
          onRefresh: loadPDFS,
          child: listview(),
        ),
        floatingActionButton: Visibility(
          visible: FirebaseAuth.instance.currentUser!.email ==
                  'chowdhuryittehad@gmail.com'
              ? true
              : false,
          child: FloatingActionButton.extended(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles();
              PlatformFile? pickedFile = result?.files.first;
              final path = str + pickedFile!.name;
              print(path);
              final file = File(pickedFile!.path!);
              final ref = FirebaseStorage.instance.ref().child(path);
              ref.putFile(file);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Uploaded ${pickedFile!.name}')),
              );
            },
            backgroundColor: gPrimaryColor,
            foregroundColor: gPrimaryColorDark,
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ),
      );

  Future<String> printUrl(String str) async {
    final ref = FirebaseStorage.instance.ref().child(str);
    String url;
    url = (await ref.getDownloadURL()).toString();
    return url;
  }

  Future<void> downlaodFile(String st, final file, int index) async {
    PermissionStatus statuses = await Permission.storage.request();
    if (statuses!.isGranted) {
      Directory dir = await getApplicationDocumentsDirectory();
      if (dir != null) {
        String savename = file.name;
        String savePath = '/storage/emulated/0/Download' + "/$savename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(st, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              setState(() {
                percent = received / total;
                downloadIndex = index;
              });
              //you can build progressbar feature too
            }
          });
          setState(() {
            percent = -1;
            downloadIndex = -1;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded ${file.name}')),
          );
          print("File is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    } else {
      print("No permission to read and write.");
    }
    return;
  }

  Future<void> loadPDFS() async {
    setState(() {
      futureFiles = FirebaseStorage.instance.ref(str).listAll();
    });
  }

  FutureBuilder listview() => FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                printUrl(str + file.name);
                return FirebaseAuth.instance.currentUser!.email ==
                        'chowdhuryittehad@gmail.com'
                    ? Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          // String str = 'Are you sure you want to delete ' + file.name;
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Warning!"),
                              content: Text('Are you sure you want to delete ' +
                                  file.name),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() async {
                                      String st =
                                          await printUrl(str + file.name);
                                      files.removeAt(index);
                                      FirebaseStorage.instance
                                          .refFromURL(st)
                                          .delete();
                                      Navigator.of(ctx).pop();
                                    });
                                  },
                                  child: Container(
                                    color: gPrimaryColor,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("YES"),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    setState(() {});
                                  },
                                  child: Container(
                                    color: gPrimaryColor,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("NO"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(300.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(file.name),
                          subtitle: (percent != -1 && downloadIndex == index)
                              ? LinearProgressIndicator(
                                  value: percent,
                                  backgroundColor: Colors.grey,
                                )
                              : null,
                          trailing: Wrap(
                            spacing: 2,
                            children: <Widget>[
                              IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    String st = await printUrl(str + file.name);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyHomePage(st),
                                        ));
                                  }),
                              IconButton(
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  String st = await printUrl(str + file.name);
                                  return downlaodFile(st, file, index);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListTile(
                        title: Text(file.name),
                        subtitle: (percent != -1 && downloadIndex == index)
                            ? LinearProgressIndicator(
                                value: percent,
                                backgroundColor: Colors.grey,
                              )
                            : null,
                        trailing: Wrap(
                          spacing: 2,
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  String st = await printUrl(str + file.name);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage(st),
                                      ));
                                }),
                            IconButton(
                              icon: const Icon(
                                Icons.download,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                String st = await printUrl(str + file.name);
                                return downlaodFile(st, file, index);
                              },
                            ),
                          ],
                        ),
                      );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
