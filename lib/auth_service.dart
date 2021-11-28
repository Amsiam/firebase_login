import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getBool("login") ?? false);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool("login", true);

      Fluttertoast.showToast(msg: "Loged successfully.");
      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool("login", true);
      Fluttertoast.showToast(msg: "Registered successfully.");
      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      var result = await _auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool("login", false);
      Fluttertoast.showToast(msg: "Loged out successfully.");

      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
    return false;
  }
}
