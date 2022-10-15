import 'package:cloud_firestore/cloud_firestore.dart';

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
    });
  }
}
