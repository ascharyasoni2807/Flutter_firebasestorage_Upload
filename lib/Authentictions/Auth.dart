import 'package:firebase_auth/firebase_auth.dart';
import 'package:video/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  Userr _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? Userr(
            userId: user.uid,
          )
        : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential users = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // ignore: deprecated_member_use
      FirebaseUser firebaseUser = users.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
