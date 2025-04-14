import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskTile extends StatelessWidget {
  String? title;
  String? task;
  DateTime? completionTime;
  TaskTile({super.key, required this.title, required this.task, required this.completionTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        height: 80,
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
                Radio(value: value, groupValue: groupValue, onChanged: (_) {})
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
