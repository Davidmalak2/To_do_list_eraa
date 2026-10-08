import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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