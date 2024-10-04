import 'package:flutter/material.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';
import 'package:login_and_registration/utils/theme/theme.dart';

class AppTheme {
  static ThemeData get lightTheme => MaterialTheme().light().withExtensions;

  static ThemeData get darkTheme => MaterialTheme().dark().withExtensions;
}
