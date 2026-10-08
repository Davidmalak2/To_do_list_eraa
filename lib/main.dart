import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/core/utils/routes.dart';
import 'package:todo_list/models/task_model.dart';  
import 'package:todo_list/models/user_model.dart';
import 'package:todo_list/view/screens/add_task_screen.dart';
import 'package:todo_list/view/screens/home_screen.dart';
import 'package:todo_list/view/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(StatusTaskAdapter());

  await Hive.openBox<UserModel>('User');
  await Hive.openBox<TaskModel>('Tasks');

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.addTask: (context) => const AddTaskScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
    );
  }
}
