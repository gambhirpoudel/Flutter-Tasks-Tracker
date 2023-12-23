import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // use to generate database path

class DatabaseHelper {
  // function to open database
  static Future<Database> _openDatabase() async {
    final databasePath =
        await getDatabasesPath(); // retrive the path to the directory where database are stored
    final path = join(databasePath, 'tasks.db');
    return openDatabase(path,
        version: 1,
        onCreate:
            _createDatabase); // call the open database function of previously determined path
  }

// function to create table
  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
     Create TABLE IF NOT EXISTS tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        dueDate TEXT
) 

'''); // to create table name tasks
  }

// to insert data in table
  static Future<int> insertTasks(
      // it returns the future int that affect rows if affected return -1
      String title,
      String description,
      String dueDate) async {
    final db =
        await _openDatabase(); // to obtained refrence to database and wait the database to open
    final data = {
      'title': title,
      'description': description,
      'dueDate': dueDate
    }; // mapped the object name in data to insert data in database

    return await db.insert('tasks', data);
  }

// to display all tasks in home
  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await _openDatabase();
    return await db.query('tasks');
  }

  // to delete data
  static Future<int> deleteData(int id) async {
    final db = await _openDatabase();
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

// to return single data
  static Future<Map<String, dynamic>?> getSingleDate(int id) async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

// to update data
  static Future<int> updateData(int id, Map<String, dynamic> data) async {
    final db = await _openDatabase();
    return await db.update('tasks', data, where: 'id=?', whereArgs: [id]);
  }
}
