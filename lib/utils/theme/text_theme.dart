import 'package:flutter/material.dart';

class TextStyleTheme extends ThemeExtension<TextStyleTheme> {
  static const String _fontFamily = 'Poppins';

  static appTextTheme(ColorScheme scheme) => TextTheme(
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: scheme.surfaceContainerHighest,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: scheme.surfaceContainerHighest,
        ),
        headlineSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: scheme.surfaceContainerHighest,
        ),
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: scheme.surfaceContainerHigh,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: scheme.surfaceContainerHigh,
        ),
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: scheme.surfaceContainerHigh,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: scheme.surfaceContainer,
        ),
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: scheme.surfaceContainer,
        ),
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: scheme.surfaceContainerLow,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 8,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: scheme.surfaceContainerLow,
        ),
      );

  factory TextStyleTheme.light() {
    return TextStyleTheme.appTextTheme(const ColorScheme.light());
  }

  @override
  ThemeExtension<TextStyleTheme> lerp(
    covariant ThemeExtension<TextStyleTheme>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return TextStyleTheme.light();
  }

  @override
  ThemeExtension<TextStyleTheme> copyWith() {
    return TextStyleTheme.light();
  }
}
