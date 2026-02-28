import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:task_mate/services/auth/auth.dart';
import 'package:task_mate/services/database/database.dart';
import 'package:task_mate/models/user.dart';
import 'package:task_mate/views/screens/sign_in.dart';
import 'package:task_mate/views/screens/home.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  AuthServices auth = AuthServices();
  DatabaseService? database = DatabaseService();

  Future<void> createAcct(BuildContext context, String username, String email,
      String password) async {
    try {
      await auth.createAccount(email, password);
      await auth.signIn(email, password);
      await database!.createUser(User(
        email: email,
        username: username,
        id: FirebaseAuth.instance.currentUser!.uid,
      ));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      await auth.signIn(email, password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await auth.logOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SignInPage();
          },
        ),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
