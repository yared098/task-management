// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HiveConfig {
//   static const String _userBox = 'userBox';
//   static const String _usernameKey = 'username';
//   static const String _roleKey = 'role';

//   static Future<void> initialize() async {
//     await Hive.initFlutter();
//     await Hive.openBox(_userBox);
//   }

//   static Future<void> saveUserSession(String username, String role) async {
//     var box = await Hive.openBox(_userBox);
//     await box.put(_usernameKey, username);
//     await box.put(_roleKey, role);
//   }

//   static Future<void> clearUserSession() async {
//     var box = await Hive.openBox(_userBox);
//     await box.clear();
//   }

//   static Future<Map<String, String>> getUserSession() async {
//     var box = await Hive.openBox(_userBox);
//     final username = box.get(_usernameKey, defaultValue: '');
//     final role = box.get(_roleKey, defaultValue: '');
//     return {'username': username, 'role': role};
//   }
// }

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management/data/models/task_model.dart';
// import 'task_model.dart';  // Import your Task model

class HiveConfig {
  static const String _taskBox = 'taskBox'; // Box for tasks
  static const String _userBox = 'userBox'; // Box for user session
  static const String _usernameKey = 'username';
  static const String _roleKey = 'role';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter()); // Register the TaskAdapter
    await Hive.openBox<Task>(_taskBox);  // Open the task box for task storage
    await Hive.openBox(_userBox); // Open the user session box
  }

  static Future<void> saveUserSession(String username, String role) async {
    var box = await Hive.openBox(_userBox);
    await box.put(_usernameKey, username);
    await box.put(_roleKey, role);
  }

  static Future<void> clearUserSession() async {
    var box = await Hive.openBox(_userBox);
    await box.clear();
  }

  static Future<Map<String, String>> getUserSession() async {
    var box = await Hive.openBox(_userBox);
    final username = box.get(_usernameKey, defaultValue: '');
    final role = box.get(_roleKey, defaultValue: '');
    return {'username': username, 'role': role};
  }

  // Save a task to Hive
  static Future<void> saveTask(Task task) async {
    var box = await Hive.openBox<Task>(_taskBox);
    await box.add(task); // Add task to the box
  }

  // Get all tasks from Hive
  static Future<List<Task>> getAllTasks() async {
    var box = await Hive.openBox<Task>(_taskBox);
    return box.values.toList(); // Return all tasks as a list
  }

  // Clear tasks from Hive
  static Future<void> clearTasks() async {
    var box = await Hive.openBox<Task>(_taskBox);
    await box.clear(); // Clear all tasks from the box
  }
}
