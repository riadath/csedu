import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csedu/Constants.dart';
import 'package:csedu/firebase_storage_image.dart';
import 'package:csedu/rounded_button.dart';
import 'package:csedu/rounded_input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                image: AssetImage('images/vectorWave2.jpg'),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class AddAlumniProfile extends StatefulWidget {
  const AddAlumniProfile({super.key});

  @override
  State<AddAlumniProfile> createState() => _AddAlumniProfileState();
}

class _AddAlumniProfileState extends State<AddAlumniProfile> {
  String errorMessage = "";
  var batchnoController = TextEditingController();
  var bloodgroupController = TextEditingController();
  var linkedinController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  bool ifImage = false;
  final StorageImage imageStorage = StorageImage();
  @override
  void dispose() {
    batchnoController.dispose();
    bloodgroupController.dispose();
    linkedinController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('alumni');

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.01),
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
                color: gPrimaryColorLight,
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            // ElevatedButton.icon(
            //   label: const Text('Upload Pofile Photo'),
            //   icon: const Icon(Icons.image),
            //   onPressed: () async {
            //     final result = await FilePicker.platform.pickFiles(
            //         allowMultiple: false,
            //         type: FileType.custom,
            //         allowedExtensions: ['png', 'jpg', 'jpeg', 'svg']);
            //     if (result != null) {
            //       ifImage = true;
            //     } else {
            //       return;
            //     }
            //     final path = result.files.single.path!;
            //     final fileName = FirebaseAuth.instance.currentUser!.uid;
            //     imageStorage.uploadFile(path, fileName);
            //   },
            // ),
            RoundedInputField(
              hintText: 'Name',
              icon: Icons.person,
              onChagned: (value) {},
              controller: nameController,
            ),
            RoundedInputField(
              hintText: 'Email',
              icon: Icons.email,
              onChagned: (value) {},
              controller: emailController,
            ),
            RoundedInputField(
              hintText: 'Batch',
              icon: Icons.date_range,
              onChagned: (value) {},
              controller: batchnoController,
            ),
            RoundedInputField(
              hintText: 'Blood Group',
              icon: Icons.bloodtype,
              onChagned: (value) {},
              controller: bloodgroupController,
            ),
            RoundedInputField(
              hintText: 'LinkedIn',
              icon: Icons.person_add_sharp,
              onChagned: (value) {},
              controller: linkedinController,
            ),
            RoundedButton(
              buttonText: 'Add Profile',
              onPress: () {
                //change the data
                int batch = 0;
                String name = nameController.text;
                String email = emailController.text;
                try {
                  batch = int.parse(batchnoController.text);
                } catch (e) {}
                String bloodGroup = bloodgroupController.text;
                String linkedin = linkedinController.text;

                bool flag = checkInput(name, email, bloodGroup, batch);

                if (!flag) {
                  setState(() {});
                } else {
                  Navigator.pop(context);
                  final docUser = _usersRef.doc(email);
                  docUser.set({
                    'name': name,
                    'email': email,
                    'batch': batch,
                    'bloodGroup': bloodGroup,
                    'linkedin': linkedin,
                  });
                }
              },
              textColor: gPrimaryColorDark,
            )
          ],
        ),
      ),
    );
  }

  bool checkInput(String name, String email, String bloodGroup, int batch) {
    return true;
  }
}
