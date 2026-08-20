import 'package:flutter/material.dart';

class MnTokens extends ThemeExtension<MnTokens> {
  const MnTokens({
    required this.canvas,
    required this.surface,
    required this.surface2,
    required this.line,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.brand,
    required this.actToday,
    required this.undated,
    required this.decision,
    required this.confirmed,
    required this.lime,
    required this.border,
    required this.space,
    required this.radius,
    required this.displayFamily,
  });

  final Color canvas;
  final Color surface;
  final Color surface2;
  final Color line;
  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color brand;
  final Color actToday;
  final Color undated;
  final Color decision;
  final Color confirmed;
  final Color lime;
  final double border;
  final double space;
  final double radius;
  final String displayFamily;

  static MnTokens of(BuildContext context) {
    final tokens = Theme.of(context).extension<MnTokens>();
    if (tokens == null) {
      throw StateError('MnTokens must be installed on ThemeData.extensions');
    }
    return tokens;
  }

  Color typeAccent(String type) {
    return switch (type) {
      'undated_action' => undated,
      'decision' => decision,
      _ => brand,
    };
  }

  @override
  MnTokens copyWith({
    Color? canvas,
    Color? surface,
    Color? surface2,
    Color? line,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? brand,
    Color? actToday,
    Color? undated,
    Color? decision,
    Color? confirmed,
    Color? lime,
    double? border,
    double? space,
    double? radius,
    String? displayFamily,
  }) {
    return MnTokens(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      line: line ?? this.line,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      ink3: ink3 ?? this.ink3,
      brand: brand ?? this.brand,
      actToday: actToday ?? this.actToday,
      undated: undated ?? this.undated,
      decision: decision ?? this.decision,
      confirmed: confirmed ?? this.confirmed,
      lime: lime ?? this.lime,
      border: border ?? this.border,
      space: space ?? this.space,
      radius: radius ?? this.radius,
      displayFamily: displayFamily ?? this.displayFamily,
    );
  }

  @override
  MnTokens lerp(ThemeExtension<MnTokens>? other, double t) {
    if (other is! MnTokens) return this;
    return MnTokens(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      line: Color.lerp(line, other.line, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      ink3: Color.lerp(ink3, other.ink3, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      actToday: Color.lerp(actToday, other.actToday, t)!,
      undated: Color.lerp(undated, other.undated, t)!,
      decision: Color.lerp(decision, other.decision, t)!,
      confirmed: Color.lerp(confirmed, other.confirmed, t)!,
      lime: Color.lerp(lime, other.lime, t)!,
      border: border + (other.border - border) * t,
      space: space + (other.space - space) * t,
      radius: radius + (other.radius - radius) * t,
      displayFamily: t < 0.5 ? displayFamily : other.displayFamily,
    );
  }
}

/// Spacing used by older screens until they read [MnTokens].
abstract final class AppTokens {
  static const space = 16.0;
  static const radius = 4.0;
}
