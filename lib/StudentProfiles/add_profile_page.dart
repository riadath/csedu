import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/firebase_storage_image.dart';
import 'package:csedu/rounded_button.dart';
import 'package:csedu/rounded_input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String batchHintText = "";
String bloodHintText = "";
String linkedinHintText = "";
String rollHintText = "";
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
  var rollController = TextEditingController();
  bool ifImage = false;
  final StorageImage imageStorage = StorageImage();
  @override
  void dispose() {
    batchnoController.dispose();
    bloodgroupController.dispose();
    linkedinController.dispose();
    rollController.dispose();
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
          SizedBox(height: screenSize.height * 0.02),
          const Text(
            'Additional Info',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          ElevatedButton.icon(
            label: const Text('Upload Pofile Photo'),
            icon: const Icon(Icons.image),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg', 'jpeg', 'svg']);
              if (result != null) {
                ifImage = true;
              } else {
                return;
              }
              final path = result.files.single.path!;
              final fileName = FirebaseAuth.instance.currentUser!.uid;
              imageStorage.uploadFile(path, fileName);
            },
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
          RoundedInputField(
            hintText: rollHintText,
            icon: Icons.waving_hand,
            onChagned: (value) {},
            controller: rollController,
          ),
          RoundedButton(
            buttonText: myButtonText,
            onPress: () {
              //change the data
              String bno, bg, li, roll;
              if (batchnoController.text.isEmpty && batchHintText != 'Batch') {
                bno = batchHintText;
              } else {
                bno = batchnoController.text.toString();
              }
              if (bloodgroupController.text.isEmpty &&
                  bloodHintText != 'Blood Group') {
                bg = bloodHintText;
              } else {
                bg = bloodgroupController.text.toString();
              }
              if (linkedinController.text.isEmpty &&
                  linkedinHintText != 'LinkedIn') {
                li = linkedinHintText;
              } else {
                li = linkedinController.text.toString();
              }
              if (rollController.text.isEmpty && rollHintText != 'Roll') {
                roll = rollHintText;
              } else {
                roll = rollController.text.toString();
              }

              bool flag = checkInput(bno, bg, li, roll);
              if (!flag) {
                setState(() {});
              } else {
                final docUser = _usersRef.doc(uid);
                docUser.update({
                  'batch': int.parse(bno),
                  'bloodGroup': bg,
                  'linkedin': li,
                  'roll': int.parse(roll),
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

  bool checkInput(String bn1, String bg, String li, String roll) {
    int year = DateTime.now().year;

    final bloodGroupEx = RegExp(r'[A|B|AB|O][\+|\-]');
    int bno = 0;
    try {
      bno = int.parse(bn1);
    } catch (e) {
      return false;
    }
    if (bno > 27 && bno < 24) {
      errorMessage = "Invalid Batch Number";
      return false;
    }
    if (!bloodGroupEx.hasMatch(bg)) {
      errorMessage = "Invalid Blood Group";
      return false;
    }
    try {
      int troll = int.parse(roll);
      if (troll < 1) {
        errorMessage = "Invalid Roll Number";
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}

class AddProfileScreen extends StatefulWidget {
  final String batchnoht;
  final String bloodht;
  final String linkedht;
  final String rollht;
  final String buttonText;

  const AddProfileScreen(
      {required this.batchnoht,
      required this.rollht,
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
    bloodHintText = widget.bloodht;
    rollHintText = widget.rollht;
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
