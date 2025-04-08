import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_mate/models/user.dart';

class DatabaseService {
  Future createUser(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .set(user.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
  }
  
