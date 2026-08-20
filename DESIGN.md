# MissNothing — the design

One page. What we are building, decided. Supersedes the option-weighing in
`design/` and the exploration in the plan doc.

## What it is

A reliable alarm layer over unreliable notification sources. The school ERP app
notifies and cannot be trusted to wake you; Gmail has the mail and does not
alarm. This app reads allowlisted senders on-device, turns circulars into
action items, and you confirm before anything is scheduled.

Not a mail reader. Not a calendar. Not primarily a privacy app — privacy is how
the layer stays trustworthy, not the pitch.

## Architecture — on device, no server

Everything runs on the phone. `backend/` and `infra/` stay in the repo,
**written and unapplied**, because Gmail push is the one thing a device cannot
do alone and we have not yet earned the need for it. See `docs/no-server.md`
reasoning below.

```
Gmail (gmail.readonly, allowlisted senders, spam included)
  → WorkManager daily sync + on app open + on briefing tap
  → SQLCipher vault (key unwrapped from biometric-gated Android Keystore)
  → school_in rule pack  →  proposals
  → you confirm  →  local exact alarms
```

- **Platform:** Android first, sideloaded. iOS when the $99 buys dogfooding.
- **Auth:** Google Sign-In, `gmail.readonly` only. Never `gmail.send`.
- **Storage:** Drift + SQLCipher. Message ids and parse status kept forever;
  bodies pruned at 14 days.
- **Parser:** rules only. The general `school_in` pack — directive phrases,
  `X Day`, scarcity language, school-timing phrases, reference-number
  blacklist, issue-date demotion. No on-device model until the fixture corpus
  shows a detection or date miss.
- **Sync integrity:** `includeSpamTrash` on allowlist queries, `historyId` 404 →
  full resync, per-sender id-count reconciliation.

### Why no server

Gmail `users.watch` is per-user and needs your credentials held continuously
while the phone sleeps. So *push* and *nothing leaves the device* are mutually
exclusive — not hard to reconcile, impossible. Android does not need push
(WorkManager polls, exact alarms fire). Only iOS does, and the exposure is
narrow: a circular arriving after the last sync, about tomorrow, on iOS, with
nobody tapping the 20:00 briefing. Not worth a backend, CASA exposure and a
false privacy policy before one real circular has produced one real alarm.

## Layout — one, the hybrid

| Screen | Content |
|---|---|
| **Home** | Statement: *"Tomorrow: tricolour outfit. And no school bag."* Objects with laid-out ticks (*2 of 3 out*). Armed alarms visible beneath, with toggles. |
| **Review** | List, all pending visible, inline actions. **Put out / Later / Bin**; **Yes / No / Maybe** on decisions. |
| **Week** | Confirmed dated items as a ledger. `moved from` flagged, never silent. |
| **Open items** | Undated to-dos, Maybe resurfaces, missed alarms that persist. |
| **Couldn't read** | Allowlisted mail with zero extracts, plus the sync-incomplete banner. |
| **Settings** | Times, senders, this phone. |

Plus: biometric gate, Connect Gmail, allowlist picker, timings onboarding, edit,
reconnect.

No layout toggle, ever. A/B/C in `design/` differ in architecture, not skin;
they were poles to choose between, not products to ship.

## The three card types

`dated_action` · `undated_action` · `decision`. Date nullable and often null.
One item per distinct parent action. `text_raw` is a contiguous quote from the
body; sanitisation happens at render, never in storage.

## Alarms

| When | What |
|---|---|
| 20:00 | Put it out for tomorrow — names the items |
| 06:15 | Today's check — syncs on tap |
| 06:30 | Need-by, **Time Sensitive** — the alarm that matters |
| after any sync | New proposals, named |

Past-due offsets are dropped; if all are past, fire now, or defer to need-by if
it is the middle of the night. All-day items get evening-before plus need-by
only. School timings map *dispersal / pickup / assembly / lunch* to real clocks.
Rolling ~64 pending, restocked on open and on briefing tap; the two briefings
are repeating triggers and never drain.

## Skin

**Dawn / Dusk**, automatic on the clock — warm light at 06:15, lamp light at
20:00. Hearth and Notebook later, as a Settings row.

Every widget reads colour, radius and shadow from `ThemeExtension<MnTokens>`
from the first line of UI code. No hex literal outside the skin files — worth a
CI grep. Get this wrong and skins become a refactor.

## Four rules that outrank everything

1. **The item is the headline.** Never a festival name, never a circular number.
2. **Nothing hides.** Couldn't-read and sync-incomplete are destinations with
   counts. The name is a claim; the UI must be able to admit a miss.
3. **Sanitise at render only.** Stored text stays the school's exact words.
4. **Review before create.** No auto-add. The model, when it exists, proposes.

## Deferred, deliberately

Backend / Gmail push · iOS dogfooding · widgets · extra Gmail accounts ·
calendar export · kettle mode · kid mode · adult rule packs · any model
download · public store listing.

## Next three things

Nothing above matters until these land.

1. **OAuth clients** — Android (`app.missnothing` + debug SHA-1) and Web; web
   client id into `secrets.json`.
2. **Swap in the general parser** — the overfitted one is still wired up, so an
   unseen circular will look like a Gmail failure.
3. **A 4–6 hour alarm, app swiped from recents, phone locked** — the 90-second
   test cannot detect OEM suppression, which is why we lead with Android.
