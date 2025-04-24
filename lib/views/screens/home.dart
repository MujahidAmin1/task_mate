import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:task_mate/database/database.dart';
import 'package:task_mate/models/task.dart';
import 'package:task_mate/utils/kTextStyle.dart';
import 'package:task_mate/utils/namedrouting.dart';
import 'package:task_mate/views/screens/profile.dart';
import 'package:task_mate/views/screens/task_detailed_screen.dart';
import 'package:task_mate/views/widgets/modalsheet.dart';
import 'package:task_mate/views/widgets/task_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late TextEditingController titleController;
late TextEditingController subtaskTitleController;
late TextEditingController taskDetailController;
late TextEditingController subtaskDetailController;
late TextEditingController createdTimeController;
late TextEditingController completedTimeController;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    titleController = TextEditingController();
    subtaskDetailController = TextEditingController();
    taskDetailController = TextEditingController();
    subtaskDetailController = TextEditingController();
    createdTimeController = TextEditingController();
    completedTimeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    FirebaseAuth auth = FirebaseAuth.instance;
    var username = databaseService.fetchUsername(auth.currentUser!.uid);
    return Scaffold(
      backgroundColor: Color(0xFF342e37),
      appBar: AppBar(
        foregroundColor: Color(0xFFfafffd),
        backgroundColor: Color(0xff342e37),
        title: FutureBuilder<String>(
          future: username,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else {
              return Text('Hi, ${snapshot.data}');
            }
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => kNavigate(context, Profile()),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Color(0xFFA2D729),
                radius: 15,
                child: Icon(Icons.person_2_outlined),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: databaseService.readTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Tasks available.'));
          }
          List<Task> tasks = snapshot.data!;
          List<SubTask> allSubTasks = tasks
              .where((task) => task.subTasks != null)
              .expand((task) => task.subTasks!.reversed)
              .where((e) => e.isCompleted == true)
              .toList();
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            children: [
              Text(" Incompleted Tasks (${tasks.length})",
                  style: kTextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              SizedBox(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        kNavigate(
                          context,
                          TaskDetailedScreen(
                            task: tasks[index],
                          ),
                        );
                      },
                      child: TaskTile(
                        title: tasks[index].title,
                        taskDetail: tasks[index].taskDetail,
                        createdTime: tasks[index].dateCreated,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(" Completed Tasks (${allSubTasks.length})",
                  style: kTextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              SizedBox(
                height: 600,
                child: ListView.builder(
                  itemCount: allSubTasks.length,
                  itemBuilder: (context, index) {
                    return SubTaskTile(
                      subtask: allSubTasks[index],
                      onChanged: (bool? value) {},
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FilledButton(
          onPressed: () {
            showModalBottomSheet(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                context: context,
                builder: (context) {
                  return CustomModalSheet(
                    titlecontroller: titleController,
                    taskcontroller: taskDetailController,
                    dateTimecontroller: createdTimeController,
                  );
                });
          },
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFFA2D729),
            minimumSize: Size(70, 40),
          ),
          child: Text("Add task", style: TextStyle(color: Colors.black))),
    );
  }
}
