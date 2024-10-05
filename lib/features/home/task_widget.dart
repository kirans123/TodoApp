import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/data/models/task.dart';
import 'package:login_and_registration/features/home/bloc/task_bloc.dart';

class TaskWidget extends StatefulWidget {
  final List<Task> tasks;
  const TaskWidget({super.key, required this.tasks});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  List<Task> get tasks => widget.tasks;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: ValueKey(task.id),
          onDismissed: (direction) {
            context.read<TaskBloc>().add(DeleteTaskEvent(task));
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            key: ValueKey(task.id),
            title: Text(task.title),
            trailing: Checkbox(
              value: task.completed,
              onChanged: (bool? value) {
                context.read<TaskBloc>().add(CompleteTaskEvent(task));
              },
            ),
          ),
        );
      },
    );
  }
}
