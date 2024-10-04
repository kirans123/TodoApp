import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/features/home/bloc/task_bloc.dart';
import 'package:login_and_registration/features/home/search_text_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final tasks =
                  (context.read<TaskBloc>().state as TaskLoadedState).tasks;
              showSearch(context: context, delegate: TaskSearchDelegate(tasks));
            },
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TaskBloc>().add(LoadTasksEvent());
              },
              child: ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (bool? value) {
                        context.read<TaskBloc>().add(CompleteTaskEvent(task));
                      },
                    ),
                    onLongPress: () {
                      context.read<TaskBloc>().add(DeleteTaskEvent(task));
                    },
                  );
                },
              ),
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog or new screen to add task
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(controller: _controller),
      actions: [
        TextButton(
          onPressed: () {
            context.read<TaskBloc>().add(AddTaskEvent(_controller.text));
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
