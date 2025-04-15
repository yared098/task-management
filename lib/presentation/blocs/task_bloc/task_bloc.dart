import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.getAllTasks();
        print('Fetched tasks: $tasks');
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        print('Error fetching tasks: $e');
        emit(TaskError(message: e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await taskRepository.addTask(event.task);
        print('Task added: ${event.task}');
        final tasks = await taskRepository.getAllTasks();
        print('Updated tasks: $tasks');
        emit(TaskLoaded(tasks: tasks)); // Emit the updated state
      } catch (e) {
        print('Error adding task: $e');
        emit(TaskError(message: e.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        await taskRepository.updateTask(event.index, event.task);
        print('Task updated: ${event.task}');
        final tasks = await taskRepository.getAllTasks();
        emit(TaskLoaded(tasks: tasks)); // Emit the updated state
      } catch (e) {
        print('Error updating task: $e');
        emit(TaskError(message: e.toString()));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await taskRepository.deleteTask(event.index);
        print('Task deleted at index: ${event.index}');
        final tasks = await taskRepository.getAllTasks();
        emit(TaskLoaded(tasks: tasks)); // Emit the updated state
      } catch (e) {
        print('Error deleting task: $e');
        emit(TaskError(message: e.toString()));
      }
    });
  }
}
