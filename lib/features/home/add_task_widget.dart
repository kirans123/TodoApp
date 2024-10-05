import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/app/widgets/app_button%20copy.dart';
import 'package:login_and_registration/app/widgets/custom_text_form_widget.dart';
import 'package:login_and_registration/features/home/bloc/task_bloc.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';
import 'package:login_and_registration/utils/mixins/form_validation.dart';

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
