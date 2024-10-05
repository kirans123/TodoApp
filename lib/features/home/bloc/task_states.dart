part of 'task_bloc.dart';

abstract class TaskState extends Equatable {}

class TaskInitial extends TaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  TaskLoadedState(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class TaskAddedState extends TaskState {
  final Task task;

  TaskAddedState(this.task);
  @override
  List<Object?> get props => [task];
}

class TaskCompletedState extends TaskState {
  final List<Task> tasks;

  TaskCompletedState(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class TaskDeletedState extends TaskState {
  final List<Task> tasks;

  TaskDeletedState(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
