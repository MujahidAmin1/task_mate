import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:task_mate/database/database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseService database = DatabaseService();

  Future createAccount(String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credentials.toString());
      
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      throw Exception(e);
    }
  }

  Future signIn(String email, String password) async {
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credentials.toString());
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      throw Exception(e);
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      throw Exception(e);
    }
  }
}
