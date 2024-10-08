import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/models/task.dart';
import 'package:login_and_registration/data/repo/task/task_repo.dart';
import 'package:login_and_registration/data/services/api/models/app_response.dart';
import 'package:login_and_registration/utils/constants/end_points.dart';
import 'package:login_and_registration/utils/constants/keys.dart';
import 'package:login_and_registration/utils/exception/exception.dart';

class TaskRepoImpl extends TaskRepository {
  @override
  Future<bool> addTask(String title) async {
    Task task = Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        completed: false);
    // Save the task locally (whether online or offline)
    await taskDaoService.addTask(task);
    if (await connectivityService.isConnected) {
      try {
        AppResponse response = await apiService
            .post(url: AppEndPoints.todos, data: {'title': title});
        return response.isSuccess;
      } catch (e) {
        throw RepoException(e.toString());
      }
    }

    // If offline, queue the task for syncing later
    if (!(await connectivityService.isConnected)) {
      await taskDaoService.addToSyncQueue(task.id, 'add', task);
    }

    return true;
  }

  @override
  Future<void> completeTask(Task task) async {
    task = Task(id: task.id, title: task.title, completed: !task.completed);
    await taskDaoService.updateTask(task); // Update locally
    if (await connectivityService.isConnected) {
      try {
        AppResponse response = await apiService.patch(
            url: '${AppEndPoints.todos}/${task.id}',
            data: {'completed': !task.completed});
        if (!response.isSuccess) {
          throw RepoException(response.message);
        }
      } catch (e) {
        throw RepoException(e.toString());
      }
    }

    // Queue for syncing if offline
    if (!(await connectivityService.isConnected)) {
      await taskDaoService.addToSyncQueue(task.id, 'update', task);
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    await taskDaoService.deleteTask(task.id); // Delete locally
    if (await connectivityService.isConnected) {
      try {
        await apiService.delete(url: '${AppEndPoints.todos}/${task.id}');
      } catch (e) {
        throw RepoException(e.toString());
      }
    }

    // Queue for syncing if offline
    if (!(await connectivityService.isConnected)) {
      await taskDaoService.addToSyncQueue(task.id, 'delete', task);
    }
  }

  @override
  Future<List<Task>> fetchTasks() async {
    if (await connectivityService.isConnected) {
      try {
        //now first we will check if there are any tasks in the local database, if yes the fetch from the local database
        List<Task> tasks = await taskDaoService.getTasks();
        if (tasks.isNotEmpty) {
          return tasks.reversed.toList();
        }
        //if  no tasks in the local database then fetch from the server and add to the local database
        AppResponse response = await apiService.get(url: AppEndPoints.todos);
        if (response.isSuccess) {
          List<Task> taskList = response.data.isNotEmpty
              ? response.data[AppKeys.data]
                  .map<Task>((e) => Task.fromJson(e))
                  .toList()
              : [];
          // add all fetched tasks into the local database and fetch from the local database
          if (taskList.isNotEmpty) {
            await taskDaoService.addAllTasks(taskList);
            taskList = await taskDaoService.getTasks();
          }
          return taskList.reversed.toList();
        } else {
          throw RepoException(response.message);
        }
      } catch (e) {
        throw RepoException(e.toString());
      }
    } else {
      List<Task> taskList = await taskDaoService.getTasks();
      return taskList.reversed.toList();
    }
  }
}
