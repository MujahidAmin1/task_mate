import 'package:flutter/material.dart';

class CustomModalSheet extends StatelessWidget {
  TextEditingController titlecontroller;
  TextEditingController taskcontroller;
  CustomModalSheet({super.key, required this.titlecontroller, required this.taskcontroller});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          TextField(
            controller: titlecontroller,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Add task name here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          TextField(
            controller: taskcontroller,
            decoration: InputDecoration(
              labelText: 'Task Description',
              hintText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          ],
      ),
    );
  }
}
