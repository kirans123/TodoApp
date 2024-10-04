import 'package:flutter/material.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';

enum ButtonType {
  primary,
  secondary,
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final ButtonType type;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.type = ButtonType.primary,
    this.constraints,
    this.margin,
  });

  Color backgroundColor(ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return onPressed != null
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainer;
      case ButtonType.secondary:
        return theme.colorScheme.surface;
      default:
        return theme.colorScheme.primary;
    }
  }

  Color txtColor(ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return theme.colorScheme.onPrimary;
      case ButtonType.secondary:
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.onPrimary;
    }
  }

  Color borderColor(ThemeData theme) {
    return onPressed != null
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainer;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: margin ??
          EdgeInsets.symmetric(
            horizontal: theme.spacing.s20,
          ),
      child: Material(
        color: backgroundColor(theme),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            theme.borderRadius.small,
          ),
          child: Container(
            constraints: constraints ??
                BoxConstraints(
                  minHeight: theme.sizing.s12,
                  minWidth: theme.sizing.s32,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                theme.borderRadius.xSmall,
              ),
              border: Border.all(
                color: borderColor(theme),
              ),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: txtColor(theme),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
