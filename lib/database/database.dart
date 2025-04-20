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

  Future createSubTask(SubTask subTask) async {
    final subtaskDoc = FirebaseFirestore.instance.collection("subtasks").doc();
    await subtaskDoc.set(subTask.toMap());
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

  Stream<List<SubTask>> readSubTasks() {
    try {
      if (_auth.currentUser == null) {
        return Stream.value([]);
      }
      final subtasks = FirebaseFirestore.instance.collection('subtasks');
      return subtasks
          .orderBy('completionTime', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map(
              (doc) => SubTask.fromMap(
                doc.data(),
              ),
            ).toList(),
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

  Future updateSubTask(
      SubTask subtask, String title, String taskDetail, String uid) async {
    var updatedTask =
        subtask.copyWith(title: title, taskDetail: taskDetail, subTaskId: uid);
    final myTask = FirebaseFirestore.instance
        .collection("subtasks")
        .doc(updatedTask.subTaskId);
    await myTask.update(updatedTask.toMap());
  }

  Future deleteTask(Task task) async {
    var mytask =
        FirebaseFirestore.instance.collection("tasks").doc(task.taskId);
    await mytask.delete();
  }

  Future deleteSubTask(SubTask subtask) async {
    var mytask = FirebaseFirestore.instance
        .collection("subtasks")
        .doc(subtask.subTaskId);
    await mytask.delete();
  }

  Future<User> fetchUser(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return User.fromMap(userDoc.data()!);
  }
}
