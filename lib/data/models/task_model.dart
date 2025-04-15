import 'package:hive/hive.dart';

part 'task_model.g.dart'; // To generate Hive type adapter

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String status; // "Pending", "In Progress", "Completed"

  @HiveField(3)
  final String? assignedTo;

  Task({
    required this.title,
    required this.description,
    required this.status,
    this.assignedTo,
  });
   // Override the toString() method to print task details
  @override
  String toString() {
    return 'Task(title: $title, description: $description, status: $status, assignedTo: $assignedTo)';
  }
}
