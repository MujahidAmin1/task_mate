import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:task_mate/models/user.dart';

import '../models/task.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  Future createTask(Task task) async {
    final taskDoc = FirebaseFirestore.instance.collection("tasks").doc();
    await taskDoc.set(task.toMap());
  }

  Stream<List<Task>> readTasks() {
    try {
      if (_auth.currentUser == null) {
        return Stream.value([]);
      }
      final tasks = FirebaseFirestore.instance.collection("tasks");
      return tasks.orderBy("completionTime", descending: true).snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Task.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future updateTask(
      Task task, String title, String taskDetails, String uid) async {
    var updatedTask =
        task.copyWith(title: title, taskDetails: taskDetails, id: uid);
    final myTask =
        FirebaseFirestore.instance.collection("tasks").doc(updatedTask.id);
    await myTask.update(updatedTask.toMap());
  }

  Future deleteTask(Task task) async {
    var mytask = FirebaseFirestore.instance.collection("tasks").doc(task.id);
    await mytask.delete();
  }

  Future<User> fetchUser(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return User.fromMap(userDoc.data()!);
  }
}
