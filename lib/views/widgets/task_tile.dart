import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_mate/models/task.dart';
import 'package:task_mate/utils/kTextStyle.dart';
import 'package:task_mate/utils/date_formatter.dart';

final random = Random();

Color getRandomColor() {
  return colorOptions[random.nextInt(colorOptions.length)];
}

final List<Color> colorOptions = [
  Color(0xFF3C91E6), // Sky Blue
  Color(0xFFA2D729), // Bright Green
  Color(0xFFFA824C), // Orange
  Color(0xFF080708), // Black
  Color(0xFF3772FF), // Bright Blue
  Color(0xFFDF2935), // Red
  Color(0xFFFDCA40), // Yellow
];

class TaskTile extends StatelessWidget {
  final String? title;
  final String? taskDetail;
  final DateTime? createdTime;
  int? allProgress;
  int? completedProgress;
  TaskTile(
      {super.key,
      this.allProgress,
      this.completedProgress,
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
            bottom: BorderSide(color: getRandomColor(), width: 5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!, style: kTextStyle(size: 25)),
              Text("Due Date: "),
              Text(DateFormatter.toOrdinalDate(createdTime!)),
              const Divider(),
              const Text("Description: "),
              Text(taskDetail!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Progress: "),
                  CircularPercentIndicator(
                    percent: ((completedProgress! / allProgress!) * 100) / 100,
                    progressColor: Colors.black87,
                    radius: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubTaskTile extends StatelessWidget {
  final SubTask? subtask;
  final ValueChanged<bool?> onChanged;

  const SubTaskTile({
    super.key,
    required this.subtask,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: getRandomColor(), width: 5),
          ),
          color: Color(0xFFfafffd), // tile background
        ),
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subtask!.taskDetail!,
                  style: TextStyle(
                      fontSize: 20,
                      decoration: subtask!.isCompleted!
                          ? TextDecoration.lineThrough
                          : null),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(
                value: subtask!.isCompleted,
                onChanged: onChanged,
                activeColor: Color(0xFFa2d729), // green
                checkColor: Color(0xFF342e37), // inside checkmark color
                shape: CircleBorder(),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
