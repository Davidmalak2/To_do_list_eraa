import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/core/%D9%90app_dialog.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/view/widgets/choose_color_widget.dart';
import 'package:todo_list/view/widgets/custom_material_button.dart';
import 'package:todo_list/view/widgets/text_from_feild_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String dropdownButtonValue = "Pending";
  final titleTask = TextEditingController();
  final desTask = TextEditingController();
  int colorSelected = 0xff2196F3;

  @override
  void dispose() {
    titleTask.dispose();
    desTask.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                label: "Title Task",
                hint: "Enter task title",
                controller: titleTask,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                label: "Description Task",
                hint: "Enter task description",
                maxLines: 4,
                controller: desTask,
              ),
              const SizedBox(height: 15),
              const Text(
                "Status",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: dropdownButtonValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                items: const [
                  DropdownMenuItem(
                    value: "Pending",
                    child: Text(
                      "Pending",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Done",
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      dropdownButtonValue = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              ChooseColorWidget(
                clickColor: (color) {
                  colorSelected = color;
                },
              ),
              const SizedBox(height: 25),
              CustomMaterialButton(
                onPressed: () async {
                  log("Title: ${titleTask.text}");
                  log("Des: ${desTask.text}");
                  log("Status: $dropdownButtonValue");
                  log("Color: $colorSelected");

                  // حفظ المهمة في Hive Box
                  var taskBox = Hive.box<TaskModel>('Tasks');
                  await taskBox
                      .add(
                    TaskModel(
                      title: titleTask.text,
                      description: desTask.text,
                      status: dropdownButtonValue == "Pending"
                          ? StatusTask.pending
                          : StatusTask.done,
                      colorHex: colorSelected,
                    ),
                  )
                      .then((value) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    titleTask.clear();
                    desTask.clear();
                    colorSelected = 0xff2196F3;
                  }).catchError((error) {
                    if (context.mounted) {
                      AppDialog.showError(context, error.toString());
                    }
                  });
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }}