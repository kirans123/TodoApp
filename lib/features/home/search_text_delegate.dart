import 'package:flutter/material.dart';
import 'package:login_and_registration/data/models/task.dart';

class TaskSearchDelegate extends SearchDelegate<Task> {
  final List<Task> tasks;

  TaskSearchDelegate(this.tasks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Task(id: 0, title: '', completed: false));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Task> filteredTasks = tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredTasks[index].title),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
