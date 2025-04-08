import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:task_mate/auth/auth.dart';
import 'package:task_mate/database/database.dart';
import 'package:task_mate/models/user.dart';
import 'package:task_mate/views/screens/home.dart';
import 'package:task_mate/views/screens/sign_in.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices auth = AuthServices();
  DatabaseService? database = DatabaseService();

  Future<void> createAcct(BuildContext context, String username, String email,
      String password) async {
    await auth.createAccount(email, password);
    await auth.signIn(email, password);
    await database!.createUser(
      User(
      email: email,
      username: username,
      id: FirebaseAuth.instance.currentUser!.uid,
    ));
    notifyListeners();
  }
   void signIn(BuildContext context, String email, String password) async {
    try {
      await auth.signIn(email, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MyHomePage();
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await auth.logOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignInPage();
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
