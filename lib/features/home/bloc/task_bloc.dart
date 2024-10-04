import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/data/init/init_repo.dart';
import 'package:login_and_registration/data/models/task.dart';

part 'task_events.dart';
part 'task_states.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskLoadingState()) {
    on<LoadTasksEvent>(_loadTasks);
    on<AddTaskEvent>(_addTask);
    on<CompleteTaskEvent>(_completeTask);
    on<DeleteTaskEvent>(_deleteTask);
  }

  // Load tasks using TaskRepository
  Future<void> _loadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await taskRepository.fetchTasks();
      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState('Failed to load tasks: $e'));
    }
  }

  // Add task using TaskRepository
  Future<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final newTask = await taskRepository.addTask(event.title);
      emit(TaskAddedState(newTask));
      add(LoadTasksEvent()); // Re-fetch tasks after adding a new task
    } catch (e) {
      emit(TaskErrorState('Failed to add task: $e'));
    }
  }

  // Mark task as complete using TaskRepository
  Future<void> _completeTask(
      CompleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.completeTask(event.task);
      emit(TaskCompletedState(event.task));
      add(LoadTasksEvent()); // Re-fetch tasks after completing a task
      //no need to reload tasks after completing a task, just update the task in the list of local tasks
    } catch (e) {
      emit(TaskErrorState('Failed to complete task: $e'));
    }
  }

  // Delete task using TaskRepository
  Future<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.deleteTask(event.task);
      emit(TaskDeletedState(event.task));
      add(LoadTasksEvent()); // Re-fetch tasks after deleting a task
    } catch (e) {
      emit(TaskErrorState('Failed to delete task: $e'));
    }
  }
}
