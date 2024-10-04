import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    double boxWidth,
    bool isLargeScreen,
  ) builder;

  const ResponsiveLayout({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;
        double boxWidth = isLargeScreen ? 500 : constraints.maxHeight * 0.95;
        return builder(context, boxWidth, isLargeScreen);
      },
    );
  }
}
