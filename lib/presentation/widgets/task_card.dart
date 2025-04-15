import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_model.dart';


class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;

  const TaskCard({Key? key, required this.task, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: onEdit,
        ),
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(task.status),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Progress':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
