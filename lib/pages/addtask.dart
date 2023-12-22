import 'package:flutter/material.dart';
import 'package:firstdemo/databasehelper.dart';
import 'customappbar.dart';

// Define a callback function type
typedef OnTaskAddedCallback = void Function();

class AddTask extends StatefulWidget {
  final OnTaskAddedCallback onTaskAdded;

  const AddTask({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // Create controllers for text input fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  // Function to handle adding tasks
  void _addTasks() async {
    // Retrieve values from text controllers
    final title = _titleController.text;
    final description = _descriptionController.text;
    final dueDate = _dueDateController.text;

    // Insert task into the database
    int insertId =
        await DatabaseHelper.insertTasks(title, description, dueDate);

    // Call the callback function after adding a task
    if (insertId != -1) {
      widget.onTaskAdded();
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the AddTask screen after adding a task
    }
  }

  // Clean up controllers when the widget is disposed
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Use the CustomAppBar directly
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF64CCC5),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter Description',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF64CCC5),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _dueDateController,
              decoration: InputDecoration(
                labelText: 'Enter Due Date',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF64CCC5),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTasks,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF64CCC5),
              foregroundColor: const Color(0xFFDAFFFB),
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4.0,
            ),
            child: const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
