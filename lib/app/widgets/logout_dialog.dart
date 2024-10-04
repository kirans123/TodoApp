import 'package:flutter/material.dart';
import 'package:login_and_registration/app/widgets/app_button.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';
import 'package:login_and_registration/utils/theme/gap.dart';

logoutDialog({
  required BuildContext context,
  required void Function()? onYesClicked,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: LogoutDialog(
          onYesClicked: onYesClicked,
        ),
      );
    },
  );
}

class LogoutDialog extends StatelessWidget {
  final void Function()? onYesClicked;
  const LogoutDialog({
    super.key,
    this.onYesClicked,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(theme.spacing.s16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: theme.colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logout',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap.h16,
            Text(
              'Are you sure you want to logout?',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            Gap.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  onPressed: () {
                    onYesClicked?.call();
                    Navigator.pop(context);
                  },
                  text: 'Yes',
                  type: ButtonType.primary,
                  margin: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    maxHeight: theme.sizing.s10,
                    maxWidth: theme.sizing.s20,
                  ),
                ),
                Gap.w16,
                AppButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'No',
                  type: ButtonType.secondary,
                  margin: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    maxHeight: theme.sizing.s10,
                    maxWidth: theme.sizing.s20,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
