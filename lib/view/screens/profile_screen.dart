
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/core/utils/routes.dart';
import 'package:todo_list/models/user_model.dart';
import 'package:todo_list/view/widgets/text_from_feild_widget.dart' show CustomTextFormField;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Avatar Icon
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8ECF5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.person,
                  size: 100,
                  color: Color(0xFF3F51B5),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Create Your Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Custom Form Input
              CustomTextFormField(
                label: "Full Name",
                controller: fullNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 50),

              // Create Button
              MaterialButton(
                onPressed: () async {
                  // Check if name is empty
                  if (fullNameController.text.trim().isEmpty) {
                    _showError("Enter your name");
                    return;
                  }

                  await _createProfile();
                },
                color: const Color(0xFF3F51B5),
                padding: const EdgeInsets.all(10),
                minWidth: 300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createProfile() async {
    try {
      // Show loading dialog
      _showLoading();

      final userBox = Hive.box<UserModel>('User');

      final user = UserModel(
        fullName: fullNameController.text.trim(),
      );

      await userBox.put("UserKey", user);

      // Check that widget still exists
      if (!mounted) return;

      // Close loading dialog
      Navigator.of(context).pop();

      // Navigate to Home
      Navigator.of(context).pushNamed(AppRoutes.home);
    } catch (error) {
      if (!mounted) return;

      // Close loading dialog
      Navigator.of(context).pop();

      // Show error
      _showError(error.toString());
    }
  }

  Future<void> _showLoading() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showError(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(fontSize: 20),
          ),
          content: Text(
            error,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}