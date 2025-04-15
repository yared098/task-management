import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_state.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
// import '../models/task_model.dart';
class TaskFormScreen extends StatefulWidget {
  final Task? task;
  final int? index;  // Add index field for updating tasks

  const TaskFormScreen({Key? key, this.task, this.index}) : super(key: key);

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedStatus = 'Pending';
  String? assignedTo;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      selectedStatus = widget.task!.status;
      assignedTo = widget.task!.assignedTo;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current AuthState safely
    final authState = context.read<AuthBloc>().state;

    // Default role if the user is not authenticated
    String role = '';

    // Only access role if AuthState is AuthAuthenticated
    if (authState is AuthAuthenticated) {
      role = authState.role;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Create Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
              items: <String>['Pending', 'In Progress', 'Completed']
                  .map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
            ),
            if (role == 'admin') // Show this dropdown only for admin
              DropdownButton<String?>(
                value: assignedTo,
                onChanged: (value) {
                  setState(() {
                    assignedTo = value;
                  });
                },
                items: <String?>['User 1', 'User 2', null]
                    .map((String? user) {
                  return DropdownMenuItem<String?>(
                    value: user,
                    child: Text(user ?? 'Unassigned'),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  status: selectedStatus,
                  assignedTo: assignedTo,
                );

                if (widget.task == null) {
                  context.read<TaskBloc>().add(AddTask(task: task));
                } else {
                  context.read<TaskBloc>().add(UpdateTask(
                    index: widget.index!,  // Use the passed index here
                    task: task,
                  ));
                }

                Navigator.pop(context);
              },
              child: Text(widget.task == null ? 'Create Task' : 'Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
