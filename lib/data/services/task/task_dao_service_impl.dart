import 'dart:convert';

import 'package:login_and_registration/data/models/task.dart';
import 'package:login_and_registration/data/services/task/task_dao_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDaoServiceImpl implements TaskDaoService {
  Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY,
      title TEXT,
      completed INTEGER
    )
  ''');

    // This table tracks actions to sync with the server
    await db.execute('''
    CREATE TABLE sync_queue (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task_id INTEGER,
      action TEXT, 
      data TEXT,   
      timestamp INTEGER
    )
  ''');
  }

  @override
  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<int> addTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toJson());
  }

  @override
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> addToSyncQueue(int taskId, String action, Task task) async {
    final db = await database;
    return await db.insert('sync_queue', {
      'task_id': taskId,
      'action': action,
      'data': jsonEncode(task.toJson()),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    final db = await database;
    return await db.query('sync_queue', orderBy: 'timestamp ASC');
  }

  @override
  Future<int> deleteSyncQueueItem(int id) async {
    final db = await database;
    return await db.delete('sync_queue', where: 'id = ?', whereArgs: [id]);
  }
}
