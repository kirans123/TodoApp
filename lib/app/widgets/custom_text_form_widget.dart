import 'package:flutter/material.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';
import 'package:login_and_registration/utils/theme/gap.dart';

class CustomTextFormWidget extends StatelessWidget {
  const CustomTextFormWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.onChange,
    this.textInputAction,
    this.suffix,
    this.obscureText = false,
  });
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
        Gap.h4,
        SizedBox(
          height: theme.sizing.s20,
          child: TextFormField(
            controller: controller,
            onChanged: onChange,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              suffix: suffix,
            ),
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }
}
