import 'package:flutter/material.dart';

class InfoTileWidget extends StatelessWidget {
  const InfoTileWidget({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final int number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.onPrimary,
        child: Text(
          number.toString(),
          style: theme.textTheme.headlineSmall,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.surfaceContainerHigh,
        ),
      ),
    );
  }
}
