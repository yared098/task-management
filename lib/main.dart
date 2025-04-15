import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/presentation/blocs/task_bloc/task_event.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/task_list_screen.dart';
import 'config/hive_config.dart';
import 'presentation/blocs/auth_bloc/auth_bloc.dart';
import 'presentation/blocs/task_bloc/task_bloc.dart';
import 'data/repositories/task_repository.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter()); // Register the Task adapter here
  await Hive.openBox<Task>('taskBox'); // Open the box before app starts

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
final TaskRepository taskRepository = TaskRepositoryImpl(); // ✅ Correct!

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => TaskBloc(taskRepository: taskRepository)..add(LoadTasks())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Management',
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/task-list': (context) => TaskListScreen(),
        },
      ),
    );
  }
}
