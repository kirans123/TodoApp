import 'dart:convert';

import 'package:login_and_registration/data/init/init_repo.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/models/task.dart';
import 'package:login_and_registration/data/repo/sync_repo/sync_repo.dart';

class SyncRepoImpl extends SyncRepo {
  @override
  Future<void> syncPendingChanges() async {
    connectivityService.onStatusChange.listen((isConnected) {
      if (isConnected) {
        _syncQueue();
      }
    });
  }

  void _syncQueue() async {
    final pendingChanges = await taskDaoService.getSyncQueue();

    for (var change in pendingChanges) {
      final task = Task.fromJson(jsonDecode(change['data']));
      final action = change['action'];

      try {
        if (action == 'add') {
          await taskRepository.addTask(task.title); // Sync with server
        } else if (action == 'update') {
          await taskRepository.completeTask(task); // Sync with server
        } else if (action == 'delete') {
          await taskRepository.deleteTask(task); // Sync with server
        }

        // Remove from sync queue after successful sync
        await taskDaoService.deleteSyncQueueItem(change['id']);
      } catch (e) {
        print('Failed to sync $action for task ${task.title}');
      }
    }
  }
}
