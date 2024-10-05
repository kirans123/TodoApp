# login_and_registration

A new Flutter project.

## Below things are covered in this project

1. SOLID principles followed
2. API Service
3. Auth Service
4. Shared Preference Service
5. Environmental Setup
6. Error Service
7. Log Service
8. Developer Screen added for checking developer actions on dev environment
9. BlocProvider Wrapper Added with repository
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

# API Integration:

Integrate with the JSONPlaceholder API (https://jsonplaceholder.typicode.com) using the following endpoints:

1. GET /todos: Retrieve all todos.
2. POST /todos: Create a new todo.
3. PATCH /todos/: Update a todo (e.g., mark as complete).
4. DELETE /todos/: Delete a todo.
   5 Handle error scenarios and display appropriate messages to the user.

# Offline Support:

1. Cache todos locally for offline access.
2. Implement optimistic updates for a better user experience.
3. Sync local changes with the server when the connection is restored.

# Additional Features:

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
   a. If user is online then check in local whether we have tasks or not, if yes then return if no then fetch from server and store into the local db.
   b. Anyways fetched the data from local database only
   c. For any add,update,delete operation if device is online then do the suggested changes on server and then again (whether user is online/offline) perform this suggested action (add,update,delete) on local database

# Here’s a quick confirmation of your logic:

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
