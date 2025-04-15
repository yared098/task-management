import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:task_management/presentation/screens/task_form_screen.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';

import '../widgets/task_card.dart';


class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    // Load tasks when screen opens
    context.read<TaskBloc>().add(LoadTasks());
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Task List')),
    body: BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is TaskLoaded) {
          final tasks = state.tasks;

          // Debugging to check tasks before rendering
          print('Loaded tasks: $tasks');

          final authState = context.read<AuthBloc>().state;
          String role = '';

          if (authState is AuthAuthenticated) {
            role = authState.role;
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              print('Rendering task: ${task.title}'); // Debug task rendering

              if (role == 'admin' || task.assignedTo == null) {
                return TaskCard(
                  task: task,
                  onEdit: () => _navigateToTaskForm(context, task),
                );
              } else if (role == 'user' && task.assignedTo == null) {
                return Container(); // Skip tasks not assigned to the user
              }

              return Container(); // Empty container for non-relevant tasks
            },
          );
        }

        return Container(); // fallback for other states
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _navigateToTaskForm(context, null),
      child: Icon(Icons.add),
    ),
  );
}

  void _navigateToTaskForm(BuildContext context, Task? task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task),
      ),
    );
  }
}
