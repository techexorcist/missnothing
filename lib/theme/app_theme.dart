import 'package:flutter/material.dart';

import 'mn_tokens.dart';
export 'mn_tokens.dart';

ThemeData buildLightTheme() {
  const tokens = MnTokens.light;
  return _theme(
    ColorScheme.fromSeed(seedColor: tokens.brand, brightness: Brightness.light),
    tokens,
  );
}

ThemeData buildDarkTheme() {
  const tokens = MnTokens.dark;
  return _theme(
    ColorScheme.fromSeed(seedColor: tokens.brand, brightness: Brightness.dark),
    tokens,
  );
}

ThemeData _theme(ColorScheme scheme, MnTokens tokens) {
  final base =
      (scheme.brightness == Brightness.dark
              ? Typography.material2021().white
              : Typography.material2021().black)
          .apply(bodyColor: tokens.ink, displayColor: tokens.ink);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme.copyWith(
      surface: tokens.surface,
      onSurface: tokens.ink,
      primary: tokens.brand,
    ),
    scaffoldBackgroundColor: tokens.canvas,
    visualDensity: VisualDensity.standard,
    textTheme: base,
    extensions: [tokens],
    appBarTheme: AppBarTheme(
      backgroundColor: tokens.canvas,
      foregroundColor: tokens.ink,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: tokens.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: tokens.line, width: tokens.border),
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: tokens.canvas,
      indicatorColor: tokens.lime,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 11,
          letterSpacing: 0.6,
          color: tokens.ink,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(88, 48),
        backgroundColor: tokens.lime,
        foregroundColor: tokens.ink,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: tokens.line, width: tokens.border),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    ),
  );
}
