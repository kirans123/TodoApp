# Todo Application

# Setup Instructions

## Prerequisites

1. Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
2. Dart SDK: (Comes with Flutter)
3. [Xcode] (https://apps.apple.com/us/app/xcode/id497799835?mt=12) (for iOS development): if we want to running the app on iOS devices. Install Xcode
4. [Android Studio](https://developer.android.com/studio) (for Android development): Required for running the app on Android devices. Install Android Studio
5. Clone the Repository - git clone https://github.com/kirans123/TodoApp.git
6. cd TodoApp
7. run command -

```sh
flutter pub get
```

8. Do SignUp by clicking on Sign Up button
9. So Login with the specified credentials , i.e email and password you used while sign up

## Mandatory

1. As we have used firebase for login and registration , so for login and registration it is mandatory to have your device to connected to the Internet
2. Once you done with login, you can do CRUD operation offline.

### Video and apk of the app

[Link] (https://drive.google.com/drive/folders/10MRUHBFZAq_iddSG7ix51UgXGlZn_czd?usp=sharing)

## Below things are covered in this project

1. SOLID principles followed
2. API Service
3. Auth Service
4. Shared Preference Service
5. Environmental Setup
6. Error Service
7. Log Service
8. Developer Screen added for checking developer actions on dev environment
9. BlocProvider Wrapper Added with BlocProvider
10. Login and Registration using email and password added by using Firebase

## Flutter Mobile App

## Features:

1. A main screen displaying a list of tasks (todos).
2. A floating action button to add new tasks.
3. Ability to mark tasks as complete.
4. Ability to delete tasks.
5. BLoC Pattern Implementation:

# Create a TaskBloc to manage the state of tasks.

1. Implement events for loading tasks, adding tasks, completing tasks, and deleting tasks.
   2 Use StreamBuilder or BlocBuilder to rebuild the UI based on state changes.

## API Integration:

Integrate with the JSONPlaceholder API (https://jsonplaceholder.typicode.com) using the following endpoints:

1. GET /todos: Retrieve all todos.
2. POST /todos: Create a new todo.
3. PATCH /todos/: Update a todo (e.g., mark as complete).
4. DELETE /todos/: Delete a todo.
   5 Handle error scenarios and display appropriate messages to the user.

## Offline Support:

1. Cache todos locally for offline access.
2. Implement optimistic updates for a better user experience.
3. Sync local changes with the server when the connection is restored.

## Additional Features:

1. Add a simple search functionality to filter todos.
2. Implement pull-to-refresh for the todo list.
3. Bonus: Add user authentication using a mock login screen (hardcoded credentials are fine).

# Approach followed

Here we have used singletons of

1.  TaskDaoService- which will be used for CRUD of sqflite
2.  TaskRepo in this repo we will do below
    1. If Device online
       1. Fetch the todos from server
       2. Add a todo into server
       3. Delete a todo from server
       4. Update a todo from server
    2. If Device is offline
       1. If add - Then we will add a task in sync_queue table as action ‘add’, task will be stored against ‘data’ key
       2. If Delete - Then we will add a task in sync_queue table as action ‘delete’, task will be stored against ‘data’ key
       3. If Update - Then we will add a task in sync_queue table as action ‘update’, task will be stored against ‘data’ key
       4. If Fetch - Fetch the data from TaskDaoService from tasks table
    3. If device is online/offline we will add/update/delete task from tasks table
3.  Now to sync data when user comes online, then for that purpose we have used ConnectivityService which will continuously check the status of Internet
    1. When user comes online then we will fetch pending tasks from sync_queue table using TaskDaoService
    2. Here in sync_table we will have task_id, action, data -> which is nothing but the task
    3. So we will run a for loop till we get the last pending change which is to be synched by its action like below
    4. So as per the action we will call TaskRepo apis and do particular action on server
    5. And later we will delete all data from sync_table

```sh
final task = Task.fromJson(jsonDecode(change['data']));
final action = change['action'];

if (action == 'add') {
  await taskRepository.addTask(task.title); // Sync with server
} else if (action == 'update') {
  await taskRepository.completeTask(task); // Sync with server
} else if (action == 'delete') {
  await taskRepository.deleteTask(task); // Sync with server
}
// Remove from sync queue after successful sync
await taskDaoService.deleteSyncQueueItem(change['id']);
```

4. As [JsonPlaceholderGuide](https://jsonplaceholder.typicode.com/guide/) suggested that **_Important: resource will not be really updated on the server but it will be faked as if._** , so I followed below steps

   1. If user is online then check in local whether we have tasks or not, if yes then return if no then fetch from server and store into the local db.
   2. Anyways fetched the data from local database only
   3. For any add,update,delete operation if device is online then do the suggested changes on server and then again (whether user is online/offline) perform this suggested action (add,update,delete) on local database

1. Singleton of TaskDaoService using getIt:

Responsible for all local CRUD operations on the sqflite database.

2. TaskRepo:

a. When online, tasks are managed directly on the server.
b. When offline, tasks are queued in sync_queue with an appropriate action (add, update, delete), and local tasks are handled via TaskDaoService.
c. Tasks are always stored locally regardless of the network status.

3. ConnectivityService:

a. Monitors connectivity status.
b. Upon reconnecting to the internet, it fetches pending tasks from sync_queue and processes each one based on its action (add, update, delete) by calling the corresponding API in TaskRepo.
c. After syncing, the task is removed from the sync_queue.

# A brief explanation of the BLoC pattern implementation.

The TaskBloc class is an implementation of the BLoC (Business Logic Component) pattern in Flutter. It manages tasks by responding to events and emitting states, ensuring that the UI is updated accordingly. This bloc is responsible for loading, adding, completing, and deleting tasks using a task repository.

## Events

### The TaskBloc listens to the following events:

1. LoadTasksEvent: Triggers loading of tasks.
2. AddTaskEvent: Triggers the addition of a new task.
3. CompleteTaskEvent: Marks a task as complete.
4. DeleteTaskEvent: Deletes a task.

## States

### The TaskBloc can emit the following states:

1. TaskLoadingState: Emitted when tasks are being loaded.
2. TaskLoadedState: Emitted when tasks are successfully loaded.
3. TaskAddedState: Emitted when a task is successfully added.
4. TaskCompletedState: Emitted when a task is successfully completed.
5. TaskDeletedState: Emitted when a task is successfully deleted.
6. TaskErrorState: Emitted when an error occurs during any operation.

## Implementation Details

1. Loading Tasks (\_loadTasks)
   When the LoadTasksEvent is triggered, the TaskBloc fetches tasks from the repository and emits either:

TaskLoadedState (if successful), or
TaskErrorState (if an error occurs).

```sh
Future<void> _loadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
  emit(TaskLoadingState());
  try {
    final tasks = await taskRepository.fetchTasks();
    emit(TaskLoadedState(tasks));
  } catch (e) {
    emit(TaskErrorState('Failed to load tasks: $e'));
  }
}

```

2. Adding a Task (\_addTask)
   When the AddTaskEvent is triggered, the TaskBloc adds a new task via the repository and emits:

TaskAddedState (if successful), or
TaskErrorState (if the task couldn't be added).

```sh
Future<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
  try {
    final isAdded = await taskRepository.addTask(event.title);
    if (isAdded) {
      emit(TaskAddedState());
    } else {
      emit(TaskErrorState('Failed to add task'));
    }
  } catch (e) {
    emit(TaskErrorState('Failed to add task: $e'));
  }
}
```

3. Completing a Task (\_completeTask)
   The CompleteTaskEvent marks a task as completed. Instead of re-fetching all tasks from the server, it simply updates the local list of tasks, toggling the completed status of the specific task.

```sh
Future<void> _completeTask(CompleteTaskEvent event, Emitter<TaskState> emit) async {
  try {
    await taskRepository.completeTask(event.task);
    final tasks = _getCurrentTasks(state); // Retrieves current tasks from the state
    final index = tasks.indexWhere((t) => t.id == event.task.id);
    if (index != -1) {
      tasks[index] = Task(
          id: event.task.id,
          title: event.task.title,
          completed: !event.task.completed); // Toggle the completion status
      emit(TaskCompletedState(tasks));
    }
  } catch (e) {
    emit(TaskErrorState('Failed to complete task: $e'));
  }
}
```

4. Deleting a Task (\_deleteTask)
   The DeleteTaskEvent removes a task. Similar to task completion, the local list of tasks is updated by removing the deleted task without fetching all tasks again.

```sh
Future<void> _deleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
  try {
    await taskRepository.deleteTask(event.task);
    final tasks = _getCurrentTasks(state); // Retrieves current tasks from the state
    tasks.removeWhere((t) => t.id == event.task.id);
    emit(TaskDeletedState(tasks));
  } catch (e) {
    emit(TaskErrorState('Failed to delete task: $e'));
  }
}
```

Earlier \_completeTask() and **deleteTask() was emitting the same state as TaskLoadedState, so data was not updating for update and delete, so I emitted TaskCompletedState() and TaskDeletedState() state respectively for \_completeTask() and **deleteTask(), by taking current tasks with the below condition check as

```sh
final tasks = state is TaskLoadedState
    ? List<Task>.from((state as TaskLoadedState).tasks)
    : state is TaskCompletedState
        ? List<Task>.from((state as TaskCompletedState).tasks)
        : List<Task>.from((state as TaskDeletedState).tasks);
```

and updated and deleted tasks respectively.
