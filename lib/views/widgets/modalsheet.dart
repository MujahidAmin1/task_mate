// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_mate/auth/auth.dart';
import 'package:task_mate/database/database.dart';
import 'package:task_mate/models/task.dart';
import 'package:task_mate/utils/kTextStyle.dart';
import 'package:task_mate/views/screens/home.dart';

class CustomModalSheet extends StatefulWidget {
  TextEditingController titlecontroller;
  TextEditingController taskcontroller;
  TextEditingController dateTimecontroller;

  CustomModalSheet({
    super.key,
    required this.titlecontroller,
    required this.taskcontroller,
    required this.dateTimecontroller,
  });

  @override
  State<CustomModalSheet> createState() => _CustomModalSheetState();
}

class _CustomModalSheetState extends State<CustomModalSheet> {
  DateTime? _selectedDateTime;
  DatabaseService database = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
    widget.dateTimecontroller.text =
        DateFormat('MMM dd, yyyy - hh:mm a').format(_selectedDateTime!);
  }
  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime!),
    );

    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      widget.dateTimecontroller.text =
          DateFormat('MMM dd, yyyy - hh:mm a').format(_selectedDateTime!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: screenHeight * 0.65,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: ListView(
          children: [
            TextField(
              controller: widget.titlecontroller,
              decoration: InputDecoration(
                label: Text('Title'),
                floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: 'Add task name here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: Color(0xFF080708),
              maxLines: 3,
              controller: widget.taskcontroller,
              decoration: InputDecoration(
                focusColor: Color(0xFF080708),
                label: Text('Task Description'),
                floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                alignLabelWithHint: true,
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// DateTime Field (Tappable)
            GestureDetector(
              onTap: () => _pickDateTime(context),
              child: AbsorbPointer(
                child: TextField(
                  cursorColor: Color(0xFF080708),
                  controller: widget.dateTimecontroller,
                  readOnly: true,
                  decoration: InputDecoration(
                    focusColor: Color(0xff080708),
                    labelText: 'Due Date & Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                FilledButton(
                  onPressed: () async {
                    try {
                      await database.createTask(
                        Task(
                          taskId: null,
                          id: auth.currentUser!.uid,
                          title: titleController.text,
                          taskDetail: taskDetailController.text,
                          subTasks: [],
                          dateCreated: _selectedDateTime,
                        ),
                      );
                      Navigator.pop(context);
                    } on Exception catch (e) {
                      throw Exception(e);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF080708),
                    minimumSize: Size(60, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text("Add", style: kTextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(60, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text("cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
