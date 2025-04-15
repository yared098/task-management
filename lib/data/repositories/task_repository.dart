import 'package:hive/hive.dart';
import 'package:task_management/data/models/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(int index, Task task);
  Future<void> deleteTask(int index); // Add delete method
  Future<void> syncTasks();
}

class TaskRepositoryImpl implements TaskRepository {
  static const String _taskBox = 'taskBox';

  @override
  Future<List<Task>> getAllTasks() async {
    var box = await Hive.openBox<Task>(_taskBox);
    return box.values.toList();
  }

  @override
  Future<void> addTask(Task task) async {
    var box = await Hive.openBox<Task>(_taskBox);
    await box.add(task);
  }

  @override
  Future<void> updateTask(int index, Task task) async {
    var box = await Hive.openBox<Task>(_taskBox);
    if (index >= 0 && index < box.length) {
      await box.putAt(index, task);
    }
  }

  @override
  Future<void> deleteTask(int index) async {
    var box = await Hive.openBox<Task>(_taskBox);
    if (index >= 0 && index < box.length) {
      await box.deleteAt(index);
    }
  }

  @override
  Future<void> syncTasks() async {
    // Sync logic here, similar to what you've already written
    // This method can fetch tasks from a server and store them in Hive
  }
}
