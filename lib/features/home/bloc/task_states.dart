part of 'task_bloc.dart';

abstract class TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  TaskLoadedState(this.tasks);
}

class TaskAddedState extends TaskState {
  final Task task;

  TaskAddedState(this.task);
}

class TaskCompletedState extends TaskState {
  final Task task;

  TaskCompletedState(this.task);
}

class TaskDeletedState extends TaskState {
  final Task task;

  TaskDeletedState(this.task);
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}
