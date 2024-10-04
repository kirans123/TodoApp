// coverage:ignore-file

import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.show,
    required this.title,
    required this.child,
  });
  final bool show;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (show) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: title,
          location: BannerLocation.bottomEnd,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
          child: child,
        ),
      );
    } else {
      return child;
    }
  }
}
