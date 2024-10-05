part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {}

class LoadTasksEvent extends TaskEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final String title;

  AddTaskEvent(this.title);
  @override
  // TODO: implement props
  List<Object?> get props => [title];
}

class CompleteTaskEvent extends TaskEvent {
  final Task task;

  CompleteTaskEvent(this.task);
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  DeleteTaskEvent(this.task);
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
