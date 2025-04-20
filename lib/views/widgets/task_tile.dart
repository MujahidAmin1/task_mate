import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String? title;
  final String? taskDetail;
  final DateTime? createdTime;
  const TaskTile(
      {super.key,
      required this.title,
      required this.taskDetail,
      required this.createdTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            bottom: BorderSide(color: Colors.red, width: 15),
          ),
        ),
        child: Column(
          children: [
            Text(title!),
            Text(createdTime.toString()),
            const Divider(),
            const Text("Description: "),
            Text(taskDetail!),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SubTaskTile extends StatelessWidget {
  String? title;
  String? task;
  DateTime? completionTime;
  SubTaskTile({
    super.key,
    required this.title,
    required this.task,
    required this.completionTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: Colors.red, width: 15),
          ),
        ),
        height: 150,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(title!),
                    Text(task!),
                  ],
                ),
                // Radio(value: value, groupValue: groupValue, onChanged: (_) {})
              ],
            ),
            const Divider(),
            Text(completionTime.toString()),
          ],
        ),
      ),
    );
  }
}
