import 'package:flutter/material.dart';
import 'package:login_and_registration/utils/theme/index.dart' as core;
import 'package:login_and_registration/utils/theme/text_theme.dart';

extension DesignSystemExtension on ThemeData {
  ThemeData get withExtensions => copyWith(
        extensions: [
          const core.BorderRadius(),
          const core.BorderWidth(),
          const core.Sizing(),
          const core.Spacing(),
          const core.AspectRatio(),
          const core.LinearGradient(),
        ],
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: textTheme.titleSmall,
          labelStyle: textTheme.titleSmall,
          hintStyle: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(.4),
            fontWeight: FontWeight.w400,
          ),
          fillColor: colorScheme.onPrimary.withOpacity(.4),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing.s8),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing.s8),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing.s8),
            borderSide: BorderSide(color: colorScheme.onSurface),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing.s8),
            borderSide: BorderSide(
              color: colorScheme.error.withOpacity(.6),
            ),
          ),
          errorStyle: TextStyle(
            color: colorScheme.error.withOpacity(.7),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 0, horizontal: spacing.s16),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(const core.BorderRadius().large),
          ),
          constraints: const BoxConstraints(
            minHeight: 400,
            maxHeight: 600,
          ),
        ),
        textTheme: TextStyleTheme.appTextTheme(colorScheme),
        chipTheme: ChipThemeData(
          padding: EdgeInsets.zero,
          color: WidgetStateProperty.all(
            colorScheme.inversePrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.small),
            side: BorderSide(
              color: colorScheme.primary,
            ),
          ),
          backgroundColor: colorScheme.onPrimary,
          labelStyle: textTheme.bodyMedium!.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      );

  core.Spacing get spacing => extension<core.Spacing>() ?? const core.Spacing();

  core.Sizing get sizing => extension<core.Sizing>() ?? const core.Sizing();

  core.BorderWidth get borderWidth =>
      extension<core.BorderWidth>() ?? const core.BorderWidth();

  core.AspectRatio get aspectRatio =>
      extension<core.AspectRatio>() ?? const core.AspectRatio();

  core.BorderRadius get borderRadius =>
      extension<core.BorderRadius>() ?? const core.BorderRadius();

  core.LinearGradient get linearGradient =>
      extension<core.LinearGradient>() ?? const core.LinearGradient();
}
