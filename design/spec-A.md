# MissNothing — v1 visual spec

Companion to `visual-proposal-v1.html`, which is the mockup this describes.
Direction chosen: **family and friendly**. Scope: full v1 screen inventory.

Read the mockup first. This document exists to record the rules behind it, so a
screen built six weeks from now still obeys them.

## 1. The thesis

**Friendly surfaces, urgent signals.**

Warmth lives in radius, spacing, palette and voice. It never leaks into the
alarm. The `act today` badge and the need-by line stay the highest-contrast
elements on any screen they appear on.

This resolves the risk in the chosen direction: a cute app that whispers is
exactly the failure the product exists to prevent. Friendliness must not cost
legibility at 06:30 to a half-awake parent.

**No illustrations.** A solo build cannot maintain an illustration set, and a
half-maintained one looks worse than none. Friendliness comes from geometry and
copy. Icons are single-stroke, 1.8px, rounded caps — cheap to add, impossible to
get visually inconsistent.

## 2. Five rules the visuals enforce

1. **The item is the headline.** Never a festival name, never a circular number.
   A card titled "Independence Day celebration" has failed even if every other
   field is right. The parent needs "tricolour outfit, snacks bag only".
2. **Friendly surface, urgent signal.** See above.
3. **Nothing hides.** `Nothing found` and `Sync incomplete` are destinations
   with counts, not silence. The app's name is a claim; the UI must be able to
   admit a miss out loud.
4. **Sanitise at render only.** Stored text is the school's exact words. URLs,
   phone numbers, bidi and zero-width marks are stripped when drawn, never in
   storage. A crafted mail must never render as "School: call +91… urgently".
5. **Card type is never signalled by colour alone.** A 5px left edge *and* a
   worded chip, so it survives greyscale and colour-blindness.

## 3. Tokens

### Colour

| Role | Light | Dark | Used for |
|---|---|---|---|
| Canvas | `#FFF9F4` | `#17120F` | Page background |
| Surface | `#FFFFFF` | `#221B17` | Cards, rows |
| Surface-2 | `#FFF4EC` | `#2C231D` | Inset rows, secondary buttons |
| Line | `#F1E3D6` | `#3A2E26` | Borders, dividers |
| Ink | `#2A211C` | `#F6EDE5` | Primary text |
| Ink-2 | `#6E5D52` | `#C0AC9C` | Secondary text |
| Ink-3 | `#9A8878` | `#8E7C6D` | Metadata, timestamps |
| Brand | `#C2410C` | `#FB923C` | Primary action, dated type |
| Act today | `#DC2626` | `#F87171` | Urgency badge, reconnect |
| Undated | `#0369A1` | `#7DD3FC` | `undated_action` type |
| Decision | `#6D28D9` | `#C4B5FD` | `decision` type |
| Confirmed | `#15803D` | `#86EFAC` | Success, reassurance ticks |

Type accents map one-to-one onto the locked schema: `dated_action` = brand,
`undated_action` = blue, `decision` = violet. Adding a type means adding an
accent; reusing one is a bug.

### Type

System stack. Sizes are deliberately large — the primary reading moment is a
tired parent before 07:00.

| Token | Size / weight | Used for |
|---|---|---|
| Screen title | 21 / 700, −0.02em | App bar |
| Card headline | 17 / 700, −0.02em | The day, or the offer |
| Item text | 13.5 / 400, 1.35 | The school's own words |
| Row title | 13.5 / 600 | Settings, allowlist |
| Meta | 10.5–11.5 / 400 | From address, timestamps |
| Chip / badge | 10 / 700–800, 0.06em | Type label, act today |
| Need-by lock line | 13 / 700 | The single most important string |

### Shape and depth

Card radius 22, field radius 14, chips and buttons fully pill. One shadow token,
used only on cards. Nothing else floats.

## 4. Screen inventory

| # | Screen | Purpose | Notable state |
|---|---|---|---|
| 01 | Lock screen | Where the product succeeds | Four notification types |
| 02 | Biometric gate | Real key gate, not a skippable screen | Fallback to device PIN |
| 03 | Connect Gmail | Win trust; pre-warn the unverified screen | — |
| 04 | Allowlist picker | Header-only sender discovery | Counts persuade |
| 05 | Need-by + timings | Configures the whole reminder engine | Defaults 06:30 / 08:00 / 15:30 |
| 06 | Review — dated | gold-01 | Swipe, checkboxes, source address |
| 07 | Review — undated | ~⅓ of school mail | Remind-me picker instead of a date |
| 08 | Review — decision | gold-02 | Yes / No / Maybe, act-today, location |
| 09 | Edit | Correct the parser | Shows rejected date candidates |
| 10 | Nothing found | Admit parse misses | Sync-incomplete banner above |
| 11 | Agenda | Confirmed dated items | `moved from` flag |
| 12 | Upcoming | Undated to-dos, Maybe, missed | Missed items persist |
| 13 | Settings | Ordered by touch frequency | Backup warning in red |
| 14 | Reconnect | The silent killer, made loud | Full-screen block |

## 5. Notification anatomy

The lock screen is the product. Four types, all sanitised at render:

| Type | Time | Title | Body |
|---|---|---|---|
| Need-by | 06:30 | `Today — school` | Items, ` · ` separated. **Time Sensitive.** |
| Morning briefing | 06:15 | `Today: N things` | "Tap to sync and see anything that arrived overnight" |
| Evening briefing | 20:00 | `Tomorrow: <items>` | Items + "Tap to review" |
| New proposals | after any sync | `N new school items` | Date + items |

Rules:

- **Items, never a holiday title.** Same rule as the card.
- **Never the same string twice in a row.** A briefing that reads identically
  every day is swiped away within a week, and the whole iOS story depends on it
  being tapped. Empty days say "Nothing tomorrow" or suppress entirely.
- **No emoji in titles.** Grapheme-safe truncation; a split surrogate pair is a
  bug, not a cosmetic issue.
- Body caps at roughly two lines' worth; overflow becomes `+N more`.

## 6. Copy voice

Plain, warm, second person. Short sentences. No exclamation marks, no jokes in
alarms.

| Instead of | Write |
|---|---|
| "Proposal pending review" | "To review" |
| "Event on 2026-08-19" | "Tomorrow · Wed 19 Aug" |
| "No extractable content" | "We received these but couldn't read them" |
| "Token expired" | "Google signed the app out" |
| "Sync error 404" | "Sync incomplete — tap to retry" |

Never say "never miss anything again." The name already makes a claim; doubling
it in copy makes the first miss twice as bad.

## 7. Accessibility

- Body text at 13.5 minimum; nothing below 10.5, and nothing below 12 carries
  information that isn't repeated elsewhere.
- Type identity is edge + word, never hue alone.
- Every tap target ≥ 44×44.
- Dark theme is a first-class variant, not an inversion — the mockup toggles it.
- Text scaling to 200% must not clip a card; items wrap, they do not truncate.

## 8. Flutter mapping

- Material 3, `ColorScheme.fromSeed(seedColor: Color(0xFFC2410C))`, then override
  the four type accents explicitly — seeded schemes will not produce them.
- One `CardShell` widget takes `ProposalType` and derives edge colour and chip.
  Type styling lives in exactly one place.
- Notification bodies come from a single `renderItems(List<ProposalItem>)`
  function that applies sanitisation. Nothing else formats a lock-screen string.
- `flutter_local_notifications` `interruptionLevel: timeSensitive` for need-by
  only. Briefings are ordinary priority; over-using time-sensitive trains the
  user to mute the channel.

## 9. Open questions

1. **Terracotta, or too close to a food-delivery app?** Alternative: deep teal
   on the same warm canvas — keeps the warmth, loses the delivery association.
2. **Does the tab bar earn its place in v1?** Review may be the whole app until
   enough confirmed items exist for Agenda to be worth a tab.
3. **Item checkboxes** — genuinely useful ("snacks bag packed"), or clutter on a
   card seen once?
4. **Maybe on dated and undated cards too**, or decisions only?
5. **Should the evening briefing show the card stack directly** on tap, skipping
   the app's home screen?

## 10. Status

This spec describes a mockup nobody has used yet. Treat every number as a
starting point and revise after the first week of real circulars on a real
phone. The five rules in §2 are the part worth defending; everything else is
detail that should lose an argument with evidence.
