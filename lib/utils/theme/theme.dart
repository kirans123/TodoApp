import "package:flutter/material.dart";

class MaterialTheme {
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      //
      primary: Color(0xffE22629),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffFEA8A9),
      onPrimaryContainer: Color(0xffffffff),
      inversePrimary: Color(0xffFFD9D9),
      //
      surface: Color(0xffffffff),
      onSurface: Color(0xff000000),
      //
      secondary: Color(0xffa83631),
      onSecondary: Color(0xffffffff),
      //
      error: Color(0xffFF0000),
      onError: Color(0xffffffff),
      //
      outline: Color(0xffF5F5F5),
      outlineVariant: Color(0xff525252),
      surfaceContainerLowest: Color(0xffE0E0E0),
      surfaceContainerLow: Color(0xffA3A3A3),
      surfaceContainer: Color(0xff7A7A7A),
      surfaceContainerHigh: Color(0xff525252),
      surfaceContainerHighest: Color(0xff3D3D3D),

      //
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6e302b),
      surfaceTint: Color(0xff904a44),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaa6059),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff6e2f32),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffaa5f61),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff6e2f33),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaa5f62),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff231918),
      onSurfaceVariant: Color(0xff4e3f3e),
      outline: Color(0xff6c5b59),
      outlineVariant: Color(0xff897674),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2d),
      inversePrimary: Color(0xffffb4ac),
      primaryFixed: Color(0xffaa6059),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8d4842),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffaa5f61),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff8d474a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffaa5f62),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff8c474b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe8d6d4),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xfffceae8),
      surfaceContainerHigh: Color(0xfff6e4e2),
      surfaceContainerHighest: Color(0xfff1dedc),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff44100d),
      surfaceTint: Color(0xff904a44),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6e302b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff440f14),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6e2f32),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff440f15),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6e2f33),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2e211f),
      outline: Color(0xff4e3f3e),
      outlineVariant: Color(0xff4e3f3e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2d),
      inversePrimary: Color(0xffffe7e4),
      primaryFixed: Color(0xff6e302b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff521a17),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6e2f32),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff52191d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6e2f33),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff52191e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe8d6d4),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xfffceae8),
      surfaceContainerHigh: Color(0xfff6e4e2),
      surfaceContainerHighest: Color(0xfff1dedc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4ac),
      surfaceTint: Color(0xffffb4ac),
      onPrimary: Color(0xff561e1a),
      primaryContainer: Color(0xff73332e),
      onPrimaryContainer: Color(0xffffdad6),
      secondary: Color(0xffffb3b3),
      onSecondary: Color(0xff561d21),
      secondaryContainer: Color(0xff733336),
      onSecondaryContainer: Color(0xffffdad9),
      tertiary: Color(0xffffb3b4),
      onTertiary: Color(0xff561d22),
      tertiaryContainer: Color(0xff733337),
      onTertiaryContainer: Color(0xffffdada),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a1110),
      onSurface: Color(0xfff1dedc),
      onSurfaceVariant: Color(0xffd8c2bf),
      outline: Color(0xffa08c8a),
      outlineVariant: Color(0xff534341),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dedc),
      inversePrimary: Color(0xff904a44),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff3b0907),
      primaryFixedDim: Color(0xffffb4ac),
      onPrimaryFixedVariant: Color(0xff73332e),
      secondaryFixed: Color(0xffffdad9),
      onSecondaryFixed: Color(0xff3b080d),
      secondaryFixedDim: Color(0xffffb3b3),
      onSecondaryFixedVariant: Color(0xff733336),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff3b080e),
      tertiaryFixedDim: Color(0xffffb3b4),
      onTertiaryFixedVariant: Color(0xff733337),
      surfaceDim: Color(0xff1a1110),
      surfaceBright: Color(0xff423735),
      surfaceContainerLowest: Color(0xff140c0b),
      surfaceContainerLow: Color(0xff231918),
      surfaceContainer: Color(0xff271d1c),
      surfaceContainerHigh: Color(0xff322826),
      surfaceContainerHighest: Color(0xff3d3231),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffbab2),
      surfaceTint: Color(0xffffb4ac),
      onPrimary: Color(0xff330404),
      primaryContainer: Color(0xffcc7b73),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffb9b9),
      onSecondary: Color(0xff340409),
      secondaryContainer: Color(0xffcb7a7c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffb9ba),
      onTertiary: Color(0xff34030a),
      tertiaryContainer: Color(0xffcb7a7d),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a1110),
      onSurface: Color(0xfffff9f9),
      onSurfaceVariant: Color(0xffdcc6c3),
      outline: Color(0xffb39e9c),
      outlineVariant: Color(0xff927f7d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dedc),
      inversePrimary: Color(0xff74352f),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff2c0102),
      primaryFixedDim: Color(0xffffb4ac),
      onPrimaryFixedVariant: Color(0xff5e231f),
      secondaryFixed: Color(0xffffdad9),
      onSecondaryFixed: Color(0xff2c0105),
      secondaryFixedDim: Color(0xffffb3b3),
      onSecondaryFixedVariant: Color(0xff5e2326),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff2c0006),
      tertiaryFixedDim: Color(0xffffb3b4),
      onTertiaryFixedVariant: Color(0xff5e2327),
      surfaceDim: Color(0xff1a1110),
      surfaceBright: Color(0xff423735),
      surfaceContainerLowest: Color(0xff140c0b),
      surfaceContainerLow: Color(0xff231918),
      surfaceContainer: Color(0xff271d1c),
      surfaceContainerHigh: Color(0xff322826),
      surfaceContainerHighest: Color(0xff3d3231),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff9f9),
      surfaceTint: Color(0xffffb4ac),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffbab2),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffb9b9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9f9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffb9ba),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a1110),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9f9),
      outline: Color(0xffdcc6c3),
      outlineVariant: Color(0xffdcc6c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dedc),
      inversePrimary: Color(0xff4e1714),
      primaryFixed: Color(0xffffe0dc),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffbab2),
      onPrimaryFixedVariant: Color(0xff330404),
      secondaryFixed: Color(0xffffe0df),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb9b9),
      onSecondaryFixedVariant: Color(0xff340409),
      tertiaryFixed: Color(0xffffe0df),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb9ba),
      onTertiaryFixedVariant: Color(0xff34030a),
      surfaceDim: Color(0xff1a1110),
      surfaceBright: Color(0xff423735),
      surfaceContainerLowest: Color(0xff140c0b),
      surfaceContainerLow: Color(0xff231918),
      surfaceContainer: Color(0xff271d1c),
      surfaceContainerHigh: Color(0xff322826),
      surfaceContainerHighest: Color(0xff3d3231),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }
  //light input decoration theme

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
          iconTheme: IconThemeData(color: colorScheme.onSurface),
        ),
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
