class Task {
  String? id;
  String? title;
  String? taskDetails;
  bool? isCompleted;
  DateTime? completionTime;

  Task({
    this.id,
    required this.title,
    required this.taskDetails,
    required this.isCompleted,
    required this.completionTime,
  });
  Task copyWith({
    String? id,
    String? title,
    String? taskDetails,
    bool? isCompleted,
    DateTime? completionTime,
  }) {
    return Task(
      title: title,
      taskDetails: taskDetails,
      isCompleted: isCompleted,
      completionTime: completionTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'taskDetails': taskDetails,
      'isCompleted': isCompleted,
      'completionTime': completionTime!.toIso8601String(),
    };
  }

  /// Convert Firestore document to a Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      taskDetails: map['taskDetails'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      completionTime: DateTime.parse(map['completionTime']),
    );
  }
}
