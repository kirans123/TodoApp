import 'package:login_and_registration/data/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();
  Future<bool> addTask(String title);
  Future<void> completeTask(Task task);
  Future<void> deleteTask(Task task);
}
