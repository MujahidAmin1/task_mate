import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/database/database.dart';
import 'package:task_mate/models/task.dart';
import 'package:task_mate/providers/auth_provider.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        actions: [
          TextButton(
              onPressed: () {
                context.read<AuthProvider>().logout(context);
              },
              child: Text("logout"))
        ],
      ),
      body: StreamBuilder(
        stream: databaseService.readTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return Center(child: Text('No tasks available'));
          }
          List<Task> tasks = snapshot.data!;
          List<List<SubTask>> subtask =
              tasks.map((task) => task.subTasks!).toList();
          return ListView(
            children: [
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskTile(
                    title: tasks[index].title,
                    taskDetail: tasks[index].taskDetail,
                    createdTime: tasks[index].dateCreated,
                  );
                },
              ),
              ListView.builder(
                itemCount: subtask.length,
                itemBuilder: (context, index) {
                  var subtasks = tasks.where(
                      (task) => task.subTasks![index].isCompleted == true).toList();
                  return SubTaskTile(
                    title: subtasks[index].subTasks![index].title,
                    task: subtasks[index].subTasks![index].taskDetail,
                    completionTime: subtasks[index].subTasks![index].completionTime,
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FilledButton(
        onPressed: () {
          showModalBottomSheet(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              context: context,
              builder: (context) {
                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.8,
                  minChildSize: 0.3,
                  maxChildSize: 0.95,
                  builder: (context, scrollController) {
                    return CustomModalSheet(
                      scrollcontroller: scrollController,
                      titlecontroller: titleController,
                      taskcontroller: taskDetailController,
                      dateTimecontroller: createdTimeController,
                    );
                  },
                );
              });
        },
        child: Text("Add task"),
      ),
    );
  }
}
