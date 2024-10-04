part of 'task_bloc.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;

  AddTaskEvent(this.title);
}

class CompleteTaskEvent extends TaskEvent {
  final Task task;

  CompleteTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  DeleteTaskEvent(this.task);
}
