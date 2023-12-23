import 'package:flutter/material.dart';
import 'package:firstdemo/pages/edittask.dart';
import 'package:firstdemo/pages/addtask.dart';
import 'package:firstdemo/pages/customappbar.dart';
import 'package:firstdemo/databasehelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    tasks = await DatabaseHelper.getAllTasks();
    setState(() {});
  }

  void _delete(int taskId) async {
    int rowsAffected = await DatabaseHelper.deleteData(taskId);
    if (rowsAffected > 0) {
      _loadTasks();
    }
  }

  void _onTaskAdded() {
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Flutter Task Tracker'),
      body: Column(
        children: <Widget>[
          for (var task in tasks)
            Container(
              height: 150,
              width: 400,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF64CCC5),
                borderRadius: BorderRadius.circular(15.0),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Title: ${task['title']}',
                    style: const TextStyle(
                      color: Color(0xFFDAFFFB),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Description: ${task['description']}',
                    style: const TextStyle(
                      color: Color(0xFFDAFFFB),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Due Date: ${task['dueDate']}',
                    style: const TextStyle(
                      color: Color(0xFFDAFFFB),
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditTask(taskId: task['id']),
                            ),
                          ).then((result) {
                            if (result == true) {
                              _loadTasks();
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDAFFFB),
                          foregroundColor: const Color(0xFF64CCC5),
                        ),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          _delete(task['id']);
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFDAFFFB),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(onTaskAdded: _onTaskAdded),
            ),
          );
        },
        backgroundColor: const Color(0xFF64CCC5),
        child: const Icon(Icons.add),
      ),
    );
  }
}
