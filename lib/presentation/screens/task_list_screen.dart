import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:task_management/presentation/screens/task_form_screen.dart';
import 'package:task_management/presentation/screens/login_screen.dart'; // Import your login screen
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String filterStatus = 'All';

  @override
  void initState() {
    super.initState();
    // Load tasks when screen opens
    context.read<TaskBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout logic by dispatching the AuthLoggedOut event
              context.read<AuthBloc>().add(AuthLoggedOut());
              // Navigate to login screen after logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()), // Make sure LoginScreen is imported
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: filterStatus,
              onChanged: (newValue) {
                setState(() {
                  filterStatus = newValue!;
                });
                // You can trigger a load event with the updated filter here
                context.read<TaskBloc>().add(LoadTasks());
              },
              items: ['All', 'Pending', 'Completed']
                  .map((status) => DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
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

                  // Apply filter logic based on filterStatus
                  final filteredTasks = tasks.where((task) {
                    if (filterStatus == 'All') {
                      return true;
                    }
                    return task.status == filterStatus;
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
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
          ),
        ],
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
