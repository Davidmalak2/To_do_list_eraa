import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/models/task_model.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 20,
          children: const [
            SizedBox(height: 60),
            HeaderWidget(),
            TaskInfoDetails(numOfTasks: 12, numOfPending: 5, numOfDone: 7),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffE8ECF5),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.person, size: 40, color: Color(0xff3F51B5)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: const [
            Text(
              "Good Morning",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TaskInfoDetails extends StatelessWidget {
  const TaskInfoDetails({
    required this.numOfTasks,
    required this.numOfPending,
    required this.numOfDone,
    super.key,
  });

  final int numOfTasks;
  final int numOfPending;
  final int numOfDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xff3F51B5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          item(numOfTasks, "Tasks"),
          item(numOfPending, "Pending"),
          item(numOfDone, "Done"),
        ],
      ),
    );
  }

  Widget item(int num, String des) {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          des,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({required this.task, super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(task.colorHex),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                task.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(task.colorHex).withAlpha(100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.status == StatusTask.pending ? "Pending" : "Done",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(task.colorHex),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}