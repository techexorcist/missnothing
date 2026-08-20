import 'package:flutter/material.dart';

abstract final class AppTokens {
  static const amber = Color(0xFFB45309);
  static const cream = Color(0xFFFFF8F1);
  static const ink = Color(0xFF3F2A14);
  static const radius = 20.0;
  static const space = 16.0;
}

ThemeData buildLightTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppTokens.amber,
    brightness: Brightness.light,
  );
  return _theme(scheme, AppTokens.cream);
}

ThemeData buildDarkTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppTokens.amber,
    brightness: Brightness.dark,
  );
  return _theme(scheme, const Color(0xFF1C140C));
}

ThemeData _theme(ColorScheme scheme, Color scaffold) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scaffold,
    visualDensity: VisualDensity.standard,
    textTheme:
        (scheme.brightness == Brightness.dark
                ? Typography.material2021().white
                : Typography.material2021().black)
            .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface),
    appBarTheme: AppBarTheme(
      backgroundColor: scaffold,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radius),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.secondaryContainer,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
