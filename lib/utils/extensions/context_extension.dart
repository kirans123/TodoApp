import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void snackBarError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(this).colorScheme.error.withOpacity(0.5),
      ),
    );
  }

  void snackBarSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.withOpacity(0.5),
      ),
    );
  }
}
