import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:todo_list/core/utils/routes.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/models/user_model.dart';

import 'package:todo_list/view/widgets/header_widget.dart';
import 'package:todo_list/view/widgets/task_info_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];

  int numOfTasks = 0;
  int numOfPending = 0;
  int numOfDone = 0;

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),

        child: Column(
          spacing: 20,
          children: [
            const SizedBox(height: 60),

            // User Header
            HeaderWidget(
              fullName: getUserName(),
            ),

            // Tasks Numbers
            TaskInfoDetails(
              numOfTasks: numOfTasks,
              numOfPending: numOfPending,
              numOfDone: numOfDone,
            ),

            // Tasks List
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                    delete: () {
                      deleteItem(index);
                    },
                  );
                },

                itemCount: tasks.length,

                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),

      // Add Task Button
      floatingActionButton: InkWell(
        onTap: () async {
          await Navigator.of(context).pushNamed(
            AppRoutes.addTask,
          );

          // Reload tasks after returning from Add Task screen
          getAllTasks();
        },

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                offset: const Offset(5, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.all(10),

          child: const Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                size: 30,
              ),

              Text("Task"),
            ],
          ),
        ),
      ),
    );
  }

  // Get all tasks from Hive
  void getAllTasks() {
    final taskBox = Hive.box<TaskModel>('Tasks');

    tasks = taskBox.values.toList();

    // Calculate numbers
    numbers();

    if (mounted) {
      setState(() {});
    }
  }

  // Get user name from Hive
  String getUserName() {
    final userBox = Hive.box<UserModel>('User');

    final user = userBox.get("UserKey");

    return user?.fullName ?? "User";
  }

  // Calculate Tasks / Pending / Done
  void numbers() {
    // Total Tasks
    numOfTasks = tasks.length;

    // Done Tasks
    numOfDone = tasks
        .where(
          (task) => task.status == StatusTask.done,
        )
        .length;

    // Pending Tasks
    numOfPending = tasks
        .where(
          (task) => task.status == StatusTask.pending,
        )
        .length;
  }

  // Delete Task
  void deleteItem(int index) {
    final taskBox = Hive.box<TaskModel>('Tasks');

    // Delete from Hive
    taskBox.deleteAt(index);

    // Delete from local list
    tasks.removeAt(index);

    // Recalculate numbers
    numbers();

    // Update UI
    setState(() {});
  }
}

// Task Item
class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.delete,
  });

  final TaskModel task;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),

      child: Row(
        spacing: 10,
        children: [
          // Task Color
          Container(
            height: 50,
            width: 5,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(task.colorHex),
            ),
          ),

          // Task Information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,

            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                width: 200,

                child: Text(
                  task.description,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: Color(task.colorHex).withAlpha(100),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  task.status == StatusTask.pending
                      ? "Pending"
                      : "Done",

                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(task.colorHex),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Delete Button
          IconButton(
            onPressed: delete,

            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}