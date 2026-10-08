import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';

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