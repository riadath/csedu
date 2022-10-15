import 'package:csedu/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csedu/user_id.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserID? _userFromFirebaseUser(User user) {
    return UserID(uid: user.uid);
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData(name, '', 0, '', false);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
