import 'package:flutter/material.dart';
import 'package:task_mate/database/database.dart';
import 'package:task_mate/models/task.dart';
import 'package:task_mate/utils/date_formatter.dart';
import 'package:task_mate/utils/kTextStyle.dart';
import 'package:task_mate/views/widgets/task_tile.dart';

class TaskDetailedScreen extends StatefulWidget {
  final Task? task;
  const TaskDetailedScreen({super.key, this.task});

  @override
  State<TaskDetailedScreen> createState() => _TaskDetailedScreenState();
}

late TextEditingController taskDetailController;

class _TaskDetailedScreenState extends State<TaskDetailedScreen> {
  @override
  void initState() {
    taskDetailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService database = DatabaseService();
    List<SubTask> subtasks = widget.task!.subTasks!;
    return Scaffold(
      backgroundColor: const Color(0xFF342e37), // Bottom background
      body: CustomScrollView(
        slivers: [
          // Top header section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: const BoxDecoration(
                color: Color(0xFFa2d729),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back)),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      widget.task!.title!,
                      style: kTextStyle(
                        size: 30,
                        isBold: true,
                        color: const Color(0xFF342e37),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Description:\n${widget.task!.taskDetail!}",
                      style: kTextStyle(color: Color(0xFF342e37), size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Date created:\n${DateFormatter.toOrdinalDate(widget.task!.dateCreated!)}",
                      style: kTextStyle(color: Color(0xFF342e37), size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              ...subtasks.map((subtask) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SubTaskTile(
                      subtask: subtask,
                      onChanged: (bool? value) async {
                        subtask.isCompleted = value ?? false;
                        
                          await database.createSubTask(
                              widget.task!.taskId!, widget.task!.subTasks!);
                        setState(() {});
                      },
                    ),
                  )),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Create your sub tasks"),
                  const SizedBox(height: 10),
                  TextField(
                    cursorColor: Color(0xff080708),
                    controller: taskDetailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter something",
                      focusColor: Color(0xff080708),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(80, 40),
                            backgroundColor: Color(0xFFfafffd)),
                        child: Text("Cancel"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          SubTask subTask = SubTask(
                            taskDetail: taskDetailController.text,
                            isCompleted: false,
                          );
                          List<SubTask> existing = widget.task!.subTasks!;
                          existing.add(subTask);
                          await database.createSubTask(
                              widget.task!.taskId!, existing);
                          taskDetailController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Subtask added")));
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(80, 40),
                            backgroundColor: Color(0xFFa2d729)),
                        child: Text("Add"),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
