import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/models/task.dart';
import 'package:login_and_registration/data/repo/task/task_repo.dart';
import 'package:login_and_registration/data/services/api/models/app_response.dart';
import 'package:login_and_registration/utils/constants/end_points.dart';
import 'package:login_and_registration/utils/constants/keys.dart';
import 'package:login_and_registration/utils/exception/exception.dart';

class TaskRepoImpl extends TaskRepository {
  @override
  Future<Task> addTask(String title) async {
    Task task = Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        completed: false);

    if (await connectivityService.isConnected) {
      try {
        AppResponse response = await apiService
            .post(url: AppEndPoints.todos, data: {'title': title});
        if (response.isSuccess) {
          return Task.fromJson(response.data);
        } else {
          throw RepoException(response.message);
        }
      } catch (e) {
        throw RepoException(e.toString());
      }
    }
    // Save the task locally (whether online or offline)
    await taskDaoService.addTask(task);

    // If offline, queue the task for syncing later
    if (!(await connectivityService.isConnected)) {
      await taskDaoService.addToSyncQueue(task.id, 'add', task);
    }

    return task;
  }

  @override
  Future<void> completeTask(Task task) async {
    task = Task(id: task.id, title: task.title, completed: true);

    if (await connectivityService.isConnected) {
      try {
        AppResponse response = await apiService.put(
            url: '${AppEndPoints.todos}/${task.id}',
            data: {'completed': !task.completed});
        if (!response.isSuccess) {
          throw RepoException(response.message);
        }
      } catch (e) {
        throw RepoException(e.toString());
      }
    }
    await taskDaoService.updateTask(task); // Update locally

    // Queue for syncing if offline
    if (!(await connectivityService.isConnected)) {
      await taskDaoService.addToSyncQueue(task.id, 'update', task);
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    if (await connectivityService.isConnected) {
      try {
        await apiService.delete(url: '${AppEndPoints.todos}/${task.id}');
      } catch (e) {
        throw RepoException(e.toString());
      }
    }
    await taskDaoService.deleteTask(task.id); // Delete locally

    // Queue for syncing if offline
    if (!(await connectivityService.isConnected)) {
      await taskDaoService.addToSyncQueue(task.id, 'delete', task);
    }
  }

  @override
  Future<List<Task>> fetchTasks() async {
    if (await connectivityService.isConnected) {
      try {
        AppResponse response = await apiService.get(url: AppEndPoints.todos);
        if (response.isSuccess) {
          List<Task> tasks = [];

          return response.data.isNotEmpty
              ? response.data[AppKeys.data]
                  .map<Task>((e) => Task.fromJson(e))
                  .toList()
              : tasks;
        } else {
          throw RepoException(response.message);
        }
      } catch (e) {
        throw RepoException(e.toString());
      }
    } else {
      return await taskDaoService.getTasks();
    }
  }
}
