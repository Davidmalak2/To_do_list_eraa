import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/models/user_model.dart';
import 'package:todo_list/view/screens/add_task_screen.dart'; 
import 'package:todo_list/view/screens/home_screen.dart';
import 'package:todo_list/view/screens/profile_screen.dart';
import 'package:todo_list/core/utils/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapter
  Hive.registerAdapter(UserModelAdapter());

  // Open User Box
  await Hive.openBox<UserModel>('User');

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.addTask, // Set the initial route to the AddTaskScreen

      routes: {
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.addTask: (context) => const AddTaskScreen(),
      },
    );
  }
}