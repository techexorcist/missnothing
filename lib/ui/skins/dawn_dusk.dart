import '../../theme/mn_tokens.dart';
import 'package:flutter/material.dart';

/// Warm light. Used from 06:15 until 20:00.
const dawn = MnTokens(
  canvas: Color(0xFFFFF4EA),
  surface: Color(0xC7FFFFFF),
  surface2: Color(0xB3FFF6EC),
  line: Color(0x2EC4783C),
  ink: Color(0xFF43281A),
  ink2: Color(0xFF8A6448),
  ink3: Color(0xFFB79379),
  brand: Color(0xFFE0651A),
  actToday: Color(0xFFD33A2C),
  undated: Color(0xFF1E7FA8),
  decision: Color(0xFF9A4BC0),
  confirmed: Color(0xFF3E8E5A),
  lime: Color(0xFFFFE7D2),
  border: 1,
  space: 16,
  radius: 24,
  displayFamily: 'serif',
);

/// Lamp light. Used from 20:00 until 06:15.
const dusk = MnTokens(
  canvas: Color(0xFF161228),
  surface: Color(0x0FFFFFFF),
  surface2: Color(0x09FFFFFF),
  line: Color(0x1CFFFFFF),
  ink: Color(0xFFF4EFE6),
  ink2: Color(0xFFB4A9C4),
  ink3: Color(0xFF7E7396),
  brand: Color(0xFFFFB25C),
  actToday: Color(0xFFFF7A85),
  undated: Color(0xFF7FD1F0),
  decision: Color(0xFFC9A6FF),
  confirmed: Color(0xFF5FD9A8),
  lime: Color(0x29FFB25C),
  border: 1,
  space: 16,
  radius: 26,
  displayFamily: 'serif',
);

const dawnStarts = TimeOfDay(hour: 6, minute: 15);
const duskStarts = TimeOfDay(hour: 20, minute: 0);

int _minutes(TimeOfDay time) => time.hour * 60 + time.minute;

/// Dawn from 06:15, dusk from 20:00. Not a preference.
MnTokens tokensForClock(DateTime now) {
  final local = now.toLocal();
  final minutes = local.hour * 60 + local.minute;
  if (minutes >= _minutes(dawnStarts) && minutes < _minutes(duskStarts)) {
    return dawn;
  }
  return dusk;
}
