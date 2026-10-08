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

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(StatusTaskAdapter()); // <-- التعديل هنا: تسجيل Adapter الـ Enum/StatusTask

  // Open Hive boxes
  await Hive.openBox<UserModel>('User');
  await Hive.openBox<TaskModel>('Tasks');

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  String getInitialRoute() {
    final userBox = Hive.box<UserModel>('User');
    final user = userBox.get("UserKey");

    if (user == null || user.fullName.trim().isEmpty) {
      return AppRoutes.profile;
    }

    return AppRoutes.home;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Open Profile if there is no saved user.
      // Otherwise open Home.
      initialRoute: getInitialRoute(),

      routes: {
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.addTask: (context) => const AddTaskScreen(),
      },
    );
  }
}