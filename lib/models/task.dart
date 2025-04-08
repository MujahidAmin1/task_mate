class Task {
  String title;
  String taskDetails;
  bool isCompleted;
  DateTime completionTime;

  Task({
    required this.title,
    required this.taskDetails,
    required this.isCompleted,
    required this.completionTime,
  });

  /// Convert a Task object to a Firestore-compatible Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'taskDetails': taskDetails,
      'isCompleted': isCompleted,
      'completionTime': completionTime.toIso8601String(),
    };
  }

  /// Convert Firestore document to a Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      taskDetails: map['taskDetails'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      completionTime: DateTime.parse(map['completionTime']),
    );
  }
}
