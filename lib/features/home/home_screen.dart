import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/app/router/routes.dart';
import 'package:login_and_registration/app/widgets/app_button.dart';
import 'package:login_and_registration/app/widgets/custom_text_form_widget.dart';
import 'package:login_and_registration/app/widgets/logout_dialog.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/features/home/bloc/task_bloc.dart';
import 'package:login_and_registration/features/home/search_text_delegate.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';
import 'package:login_and_registration/utils/mixins/form_validation.dart';

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
      body: BlocProvider(
        create: (context) => TaskBloc()..add(LoadTasksEvent()),
        child: BlocBuilder<TaskBloc, TaskState>(
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
                      key: ValueKey(task.id),
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

class AddTaskDialog extends StatelessWidget with FormValidationMixin {
  final TextEditingController _controller = TextEditingController();

  AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Add Task'),
      content: CustomTextFormWidget(
          labelText: 'Task',
          hintText: 'Enter task',
          controller: _controller,
          validator: validateEmpty),
      actions: [
        SizedBox(
          width: theme.sizing.s28,
          child: AppButton(
            onPressed: () {
              context.read<TaskBloc>().add(AddTaskEvent(_controller.text));
              Navigator.of(context).pop();
            },
            text: 'Add',
          ),
        ),
      ],
    );
  }
}
