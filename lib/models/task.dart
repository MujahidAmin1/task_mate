import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String? taskId;
  String? title;
  String? taskDetail;
  DateTime? dateCreated;
  List<SubTask>? subTasks;
  Task({
    this.taskId,
    this.id,
    required this.title,
    required this.taskDetail,
    required this.subTasks,
    required this.dateCreated,
  });
  Task copyWith({
    String? id,
    String? taskId,
    String? title,
    String? taskDetail,
    DateTime? dateCreated,
    List<SubTask>? subTasks,
  }) {
    return Task(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      taskDetail: taskDetail ?? this.taskDetail,
      subTasks: subTasks ?? this.subTasks,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskId: map['taskId'],
      title: map['title'],
      taskDetail: map['taskDetail'],
      dateCreated: (map['dateCreated'] as Timestamp).toDate(),
      subTasks: map['subTasks'] != null
          ? List<SubTask>.from(
              map['subTasks'].map((x) => SubTask.fromMap(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'taskDetail': taskDetail,
      'dateCreated': dateCreated,
      'subTasks': subTasks?.map((x) => x.toMap()).toList(),
    };
  }
}

class SubTask {
  String? taskDetail;
  bool? isCompleted;

  SubTask({
    required this.taskDetail,
    required this.isCompleted,
  });
  SubTask copyWith({
    String? subTaskId,
    String? title,
    String? taskDetail,
    bool? isCompleted,
    DateTime? completionTime,
  }) {
    return SubTask(
      taskDetail: taskDetail,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskDetail': taskDetail,
      'isCompleted': isCompleted,
    };
  }

  /// Convert Firestore document to a SubTask object
  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      taskDetail: map['taskDetail'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
