# MissNothing — visual design proposals

Three complete directions for the same v1 scope, each covering the whole screen
inventory and using the two real circulars (gold-01, gold-02) as content. Open
the HTML files in a browser — ideally on a phone, which is what they are drawn
for. Each has a light/dark or invert control.

Kept **outside `docs/`** deliberately: `docs/` is the GitHub Pages source that
serves the privacy policy the Google OAuth consent screen points at. Anything
under it becomes publicly served, and internal design exploration should not be.

| File | Direction | Premise |
|---|---|---|
| [A-family-and-friendly.html](A-family-and-friendly.html) | **A — Family & friendly** | Warm terracotta, rounded cards, card-stack triage. Friendly surfaces, urgent signals. |
| [B-instrument.html](B-instrument.html) | **B — Instrument** | Dark-first, near-monochrome, typographic. Statement-first home; alarms are visible, toggleable objects. |
| [C-tomorrow-laid-out.html](C-tomorrow-laid-out.html) | **C — Tomorrow, laid out** | Editorial/riso. Objects instead of text, a new "laid out" state, kettle mode, kid mode. |
| [skins-gallery.html](skins-gallery.html) | **Skin gallery** | Seven skins driving the same three screens: Aurora (soft/glassy), Notebook (school diary), Dawn/Dusk (time-reactive), plus A/B/C. Live switcher = the Settings toggle, prototyped. |
| [spec-A.md](spec-A.md) | Written spec | Tokens, rules, copy voice, accessibility, Flutter mapping. Written against A; §2 rules apply to all three. |

## The question each one answers

- **A** — *What do I need to know?* Answered kindly.
- **B** — *Are my alarms actually set?* Answered like an instrument.
- **C** — *Is it out yet?* Answered as objects by the front door.

C's framing is the only one that attacks the real failure. Nobody misses colour
dress because they didn't know; they miss it because at 07:12 the outfit is not
out and there is no time.

## Product rules that hold across all three

These are not style choices and should not lose an argument to one.

1. **The item is the headline.** Never a festival name, never a circular number.
   A card titled "Independence Day celebration" has failed.
2. **Nothing hides.** Couldn't-read and sync-incomplete are destinations with
   counts. The app's name is a claim; the UI must be able to admit a miss.
3. **Sanitise at render only.** Stored text stays the school's exact words.
4. **Type is never signalled by colour alone.** Edge + word, so it reads in
   greyscale.

## Recommended hybrid

Not any one file as drawn:

- **A's palette and voice** — warmth does real work for a co-parent who didn't
  build this.
- **B's architecture** — statement-first home, armed alarms visible beneath it,
  list triage rather than one-card-at-a-time.
- **C's laid-out state and physical verbs** — a third state after proposed and
  confirmed, and *Put out / Later / Bin* instead of *Add / Skip / Maybe*.

The three poles had to exist before that was a choice rather than a guess.

## Open questions

1. Terracotta (A) or deep teal on the same warm canvas? Terracotta risks reading
   as a food-delivery app.
2. Does a tab bar earn its place in v1, or is one screen the whole app until
   there are enough confirmed items for an agenda?
3. Item checkboxes: useful, or clutter on a card seen once?
4. Does the "laid out" state nag? It needs a way to say *stop asking*.
5. Objects-over-text (C) degrades the moment a circular says "bring ₹200".
   What is the text fallback, and is it most of the long tail?

## Status

Nobody has used any of these. Every number is a starting point; revise after a
week of real circulars on a real phone.

## Multiple looks, switchable in Settings

Yes — see `skins-gallery.html`, which prototypes it. The rule that keeps it cheap:

**A skin changes tokens. A skin cannot change architecture.**

| | Skin can change | Skin cannot change |
|---|---|---|
| Examples | Colour, gradient, type family/weight, radius, border width, shadow, light/dark, lock-screen background | Which screen is home, stack vs list triage, whether alarms are visible, tab structure, gestures |
| Cost | ~zero once the token contract exists; a new skin is one file of values | A second widget tree, second test suite, double the bug surface |
| Verdict | Ship as many as you like | Pick one |

So: **one layout, many skins.** Directions A/B/C differ in architecture, not just
looks — Instrument's statement-first home is a different widget tree. Choose the
architecture once, then let the toggle carry the looks.

### Flutter mechanism

`ThemeExtension<MnTokens>` holding the tokens Material 3's `ColorScheme` doesn't
cover — the three type accents (dated / undated / decision), urgent, armed, card
radius, border width, shadow, lock gradient, display family. A `StateNotifier`
holds the active `AppSkin`; `MaterialApp` rebuilds on change; implementing
`lerp` makes the switch animate rather than snap.

**The one discipline:** no widget may hardcode a colour, radius or shadow. The
moment a card writes `Color(0xFFC2410C)` instead of reading the token, that card
is stuck in one skin forever and every other skin has a bug you'll find months
later on someone else's phone. Worth a CI grep for hex literals outside the skin
files.

### Recommended shipping set

- **Dawn / Dusk — automatic default.** Not a preference, a function of the clock.
  The app is used at 06:15 and 20:00; looking like the hour it's used in is the
  one skin idea that is also a feature.
- **Hearth** — flat and warm, for anyone who wants no gradient.
- **Notebook** — the charming option. Keep the handwriting font decorative only;
  it must never render an item or a lock-screen line.

Instrument and Riso stay documents rather than skins: Instrument is a different
architecture, and Riso will date.

### Watch out for

- Contrast in Aurora — translucent glass over a gradient is where WCAG quietly fails.
- Log the active skin with any diagnostics, or bug reports arrive in a look you
  aren't running.
