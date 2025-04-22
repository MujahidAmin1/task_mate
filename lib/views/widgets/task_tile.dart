import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_mate/utils/kTextStyle.dart';
import 'package:intl/intl.dart';
import 'package:task_mate/utils/date_formatter.dart';

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
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            bottom: BorderSide(color: Colors.red, width: 5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!, style: kTextStyle(size: 25)),
              Text(DateFormatter.toOrdinalDate(createdTime!)),
              const SizedBox(height: 20),
              const Divider(),
              const Text("Description: "),
              const SizedBox(height: 10),
              Text(taskDetail!),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SubTaskTile extends StatelessWidget {
  String? task;

  SubTaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: Colors.cyan, width: 5),
          ),
        ),
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(task!, style: kTextStyle()),
              // Radio(value: value, groupValue: groupValue, onChanged: (_) {})
            ],
          ),
        ),
      ),
    );
  }
}
