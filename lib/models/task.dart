class Task {
  String? taskId;
  String? title;
  String? taskDetail;
  DateTime? dateCreated;
  List<SubTask>? subTasks;
  Task({
    this.taskId,
    required this.title,
    required this.taskDetail,
    required this.subTasks,
    required this.dateCreated,
  });
  Task copyWith({
    String? taskId,
    String? title,
    String? taskDetail,
    DateTime? dateCreated,
    List<SubTask>? subTasks,
  }) {
    return Task(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      taskDetail: taskDetail ?? this.taskDetail,
      subTasks: subTasks ?? this.subTasks,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['taskId'],
      title: map['title'],
      taskDetail: map['taskDetail'],
      dateCreated: map['dateCreated'],
      subTasks: map['subTasks'] != null
          ? List<SubTask>.from(
              map['subTasks'].map((x) => SubTask.fromMap(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'taskDetail': taskDetail,
      'dateCreated': dateCreated,
      'subTasks': subTasks?.map((x) => x.toMap()).toList(),
    };
  }
}

class SubTask {
  String? subTaskId;
  String? title;
  String? taskDetail;
  bool? isCompleted;
  DateTime? completionTime;

  SubTask({
    this.subTaskId,
    required this.title,
    required this.taskDetail,
    required this.isCompleted,
    required this.completionTime,
  });
  SubTask copyWith({
    String? subTaskId,
    String? title,
    String? taskDetail,
    bool? isCompleted,
    DateTime? completionTime,
  }) {
    return SubTask(
      title: title,
      taskDetail: taskDetail,
      isCompleted: isCompleted,
      completionTime: completionTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subTaskId': subTaskId,
      'title': title,
      'taskDetail': taskDetail,
      'isCompleted': isCompleted,
      'completionTime': completionTime!.toIso8601String(),
    };
  }

  /// Convert Firestore document to a SubTask object
  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      subTaskId: map['subTaskId'] ?? '',
      title: map['title'] ?? '',
      taskDetail: map['taskDetail'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      completionTime: DateTime.parse(map['completionTime']),
    );
  }
}
