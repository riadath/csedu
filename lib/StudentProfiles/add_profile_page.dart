import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/rounded_button.dart';
import 'package:csedu/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String batchHintText = "";
String bloodHintText = "";
String linkedinHintText = "";
String myButtonText = "";

class Background extends StatefulWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('images/vectorWave1.jpg'),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class AddProfileWidget extends StatefulWidget {
  const AddProfileWidget({super.key});

  @override
  State<AddProfileWidget> createState() => _AddProfileWidgetState();
}

class _AddProfileWidgetState extends State<AddProfileWidget> {
  String errorMessage = "";
  var batchnoController = TextEditingController();
  var bloodgroupController = TextEditingController();
  var linkedinController = TextEditingController();

  @override
  void dispose() {
    batchnoController.dispose();
    bloodgroupController.dispose();
    linkedinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');
  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.1),
          Text(errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
              )),
          SizedBox(height: screenSize.height * 0.1),
          const Text(
            'Additional Info',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          RoundedInputField(
            hintText: batchHintText,
            icon: Icons.date_range,
            onChagned: (value) {},
            controller: batchnoController,
          ),
          RoundedInputField(
            hintText: bloodHintText,
            icon: Icons.bloodtype,
            onChagned: (value) {},
            controller: bloodgroupController,
          ),
          RoundedInputField(
            hintText: linkedinHintText,
            icon: Icons.person_outline_sharp,
            onChagned: (value) {},
            controller: linkedinController,
          ),
          RoundedButton(
            buttonText: myButtonText,
            onPress: () {
              //change the data
              int bno = int.parse(batchnoController.text.toString());
              String bg = bloodgroupController.text.toString();
              String li = linkedinController.text.toString();
              bool flag = checkInput(bno, bg, li);
              if (!flag) {
                setState(() {});
              } else {
                final docUser = _usersRef.doc(uid);
                docUser.update({
                  'batch': bno,
                  'bloodGroup': bg,
                  'linkedin': li,
                  'showData': true,
                });
                Navigator.pop(context);
              }
            },
            textColor: gPrimaryColorDark,
          )
        ],
      ),
    );
  }

  bool checkInput(int bno, String bg, String li) {
    int year = DateTime.now().year;

    final bloodGroupEx = RegExp(r'[A|B|AB|O][\+|\-]');

    if (bno > (year - 1994) && bno < (year - 1989)) {
      errorMessage = "Invalid Batch Number";
      return false;
    }
    if (!bloodGroupEx.hasMatch(bg)) {
      errorMessage = "Invalid Blood Group";
      return false;
    }
    return true;
  }
}

class AddProfileScreen extends StatefulWidget {
  final String batchnoht;
  final String bloodht;
  final String linkedht;
  final String buttonText;
  const AddProfileScreen(
      {required this.batchnoht,
      required this.bloodht,
      required this.linkedht,
      required this.buttonText,
      super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  @override
  void initState() {
    batchHintText = widget.batchnoht;
    bloodHintText = widget.bloodht;
    linkedinHintText = widget.linkedht;
    myButtonText = widget.buttonText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: AddProfileWidget(),
        ));
  }
}
