import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return res;
    } catch (err) {
      if (err.toString().contains('ERROR_WRONG_PASSWORD')) {
        Fluttertoast.showToast(msg: "Login fehlgeschlagen. Falsches Passwort.");
      } else if (err.toString().contains('ERROR_INVALID_EMAIL')) {
        Fluttertoast.showToast(msg: "Login fehlgeschlagen. Fehlerhafte Email.");
      } else if (err.toString().contains('ERROR_USER_NOT_FOUND')) {
        Fluttertoast.showToast(
            msg: "Login fehlgeschlagen. Email konnte nicht gefunden werden.");
      } else {
        Fluttertoast.showToast(msg: "Unknown error.");
      }
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (err) {
      if (err.toString().contains('ERROR_INVALID_EMAIL')) {
        Fluttertoast.showToast(
            msg: "Operation fehlgeschlagen. Fehlerhafte Email.");
      } else if (err.toString().contains('ERROR_USER_NOT_FOUND')) {
        Fluttertoast.showToast(
            msg:
                "Operation fehlgeschlagen. Email konnte nicht gefunden werden.");
      } else {
        Fluttertoast.showToast(msg: 'Unknown error.');
      }
      return null;
    }
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err);
      return null;
    }
  }
}
