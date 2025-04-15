import 'package:task_management/data/models/task_model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  AddTask({required this.task});
}

class UpdateTask extends TaskEvent {
  final int index; // The index of the task to update
  final Task task; // The updated task

  UpdateTask({required this.index, required this.task});
}

class DeleteTask extends TaskEvent {
  final int index; // The index of the task to delete

  DeleteTask({required this.index});
}

class GetTasks extends TaskEvent {}
