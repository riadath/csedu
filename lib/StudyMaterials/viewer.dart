import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyHomePage extends StatefulWidget {
  String str;
  MyHomePage(this.str);
  @override
  State<MyHomePage> createState() {
    return _MyHomePageState(str);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String up;
  _MyHomePageState(this.up);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold( body: SfPdfViewer.network(
        up) ) );
  }
}
