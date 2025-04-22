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

  Future<void> createTask(Task task) async {
    final taskDoc = FirebaseFirestore.instance.collection("tasks").doc();
    task.taskId = taskDoc.id;
    await taskDoc.set(task.toMap());
  }

  Future<void> createSubTask(String taskId, List<SubTask> subtasks) async {
    final taskDoc = FirebaseFirestore.instance.collection("tasks").doc(taskId);
    await taskDoc.update({
      'subTasks': subtasks.map((e) => e.toMap()).toList(),
    });
  }

  Stream<List<Task>> readTasks() {
    try {
      if (_auth.currentUser == null) {
        return Stream.value([]);
      }
      final tasks = FirebaseFirestore.instance.collection("tasks");
      return tasks.orderBy("dateCreated", descending: true).snapshots().map(
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


  Future updateTask(Task task, String title, String id) async {
    final update = task.copyWith(title: title, taskId: id);
    final mytasks =
        FirebaseFirestore.instance.collection("tasks").doc(update.taskId);
    await mytasks.update(update.toMap());
  }



  Future deleteTask(Task task) async {
    var mytask =
        FirebaseFirestore.instance.collection("tasks").doc(task.taskId);
    await mytask.delete();
  }
  Future<User> fetchUser(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return User.fromMap(userDoc.data()!);
  }
}
