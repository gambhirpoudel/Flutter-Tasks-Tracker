import 'package:flutter/material.dart';
import 'package:firstdemo/databasehelper.dart';
import 'customappbar.dart';

class EditTask extends StatefulWidget {
  final int taskId;

  const EditTask({Key? key, required this.taskId}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  void fetchData() async {
    Map<String, dynamic>? data =
        await DatabaseHelper.getSingleDate(widget.taskId);
    if (data != null) {
      setState(() {
        _titleController.text = data['title'];
        _descriptionController.text = data['description'];
        _dueDateController.text = data['dueDate'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void _updateData(BuildContext context) async {
    Map<String, dynamic> data = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'dueDate': _dueDateController.text,
    };
    int id = await DatabaseHelper.updateData(widget.taskId, data);

    if (id > 0) {
      // Update successful
      Navigator.pop(context, true);
    } else {
      // Update failed
      // Handle the error or display a message
      print('Update failed');
    }
  }

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
      appBar: const CustomAppBar(),
      body: Column(
        children: [
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
                labelText: 'Enter DueDate',
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
            onPressed: () {
              _updateData(context);
            },
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
              'Update Task',
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
