import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name, String linkedin, int batch,
      String bloodGroup, bool showData) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'linkedin': linkedin,
      'batch': batch,
      'bloodGroup': bloodGroup,
      'showData': showData,
      'uid': uid,
    });
  }
  static String retBatch(){
    String ret = '';
    final CollectionReference _usersRef =
    FirebaseFirestore.instance.collection('users');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = _usersRef.doc(uid);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        ret = data['batch'].toString();
      },
      onError: (e) => print('Could not retrive data'),
    );
    print(ret);
    return ret;
  }
}
