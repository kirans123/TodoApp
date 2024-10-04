import 'package:login_and_registration/data/models/task.dart';
import 'package:sqflite/sqflite.dart';

abstract class TaskDaoService {
  Future<Database> get database;

  Future<List<Task>> getTasks();

  Future<int> addTask(Task task);

  Future<int> updateTask(Task task);

  Future<int> deleteTask(int id);
  Future<void> addAllTasks(List<Task> tasks);
  Future<int> deleteAllTasks();
  Future<int> addToSyncQueue(int taskId, String action, Task task);
  Future<List<Map<String, dynamic>>> getSyncQueue();
  Future<int> deleteSyncQueueItem(int id);
}
