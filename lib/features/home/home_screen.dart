import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/app/router/routes.dart';
import 'package:login_and_registration/app/widgets/logout_dialog.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/models/task.dart';
import 'package:login_and_registration/features/home/add_task_widget.dart';
import 'package:login_and_registration/features/home/bloc/task_bloc.dart';
import 'package:login_and_registration/features/home/search_text_delegate.dart';
import 'package:login_and_registration/features/home/task_widget.dart';
import 'package:login_and_registration/utils/extensions/context_extension.dart';

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
              final state = context.read<TaskBloc>().state;
              final tasks = state is TaskLoadedState
                  ? List<Task>.from((state).tasks)
                  : state is TaskCompletedState
                      ? List<Task>.from((state).tasks)
                      : List<Task>.from((state as TaskDeletedState).tasks);
              showSearch(context: context, delegate: TaskSearchDelegate(tasks));
            },
          ),
          //logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Show dialog to confirm logout

              logoutDialog(
                  context: context,
                  onYesClicked: () {
                    authService.clear().then((value) {
                      const LoginRoute().go(context);
                    });
                  });
            },
          ),
        ],
      ),
      body: BlocConsumer(
        bloc: context.read<TaskBloc>(),
        listener: (context, state) {
          if (state is TaskAddedState) {
            context.read<TaskBloc>().add(LoadTasksEvent());
            context.snackBarSuccess('Task added successfully');
          }
          if (state is TaskErrorState) {
            context.snackBarError(state.message);
          }
        },
        builder: (context, state) {
          final List<Task> tasks = [];
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            tasks.addAll(state.tasks);
          } else if (state is TaskCompletedState) {
            tasks.clear();
            tasks.addAll(state.tasks);
          } else if (state is TaskDeletedState) {
            tasks.clear();
            tasks.addAll(state.tasks);
          }
          return RefreshIndicator(
              onRefresh: () async {
                context.read<TaskBloc>().add(LoadTasksEvent());
              },
              child: TaskWidget(tasks: tasks));
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
