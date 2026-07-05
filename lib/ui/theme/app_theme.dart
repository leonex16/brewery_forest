import 'package:brewery_forest/ui/theme/app_typography.dart';
import 'package:brewery_forest/ui/theme/color_schemes.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(lightColorScheme);
  static ThemeData dark() => _build(darkColorScheme);

  static ThemeData _build(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'Outfit',
      textTheme: appTextTheme,

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 56),
          shape: const StadiumBorder(),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 56),
          shape: const StadiumBorder(),
          side: BorderSide(color: scheme.tertiary, width: 2),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: const StadiumBorder()),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),

      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),

      listTileTheme: const ListTileThemeData(minTileHeight: 64),

      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: const CircleBorder(),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.primary,
        elevation: 0,
        centerTitle: false,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
    );
  }
}
