# Product

## Register

product

## Users

Jemo, the administrator of the church's SongDB. Uses the app alone, typically between services or during prep: pull up a song fast to read its lyrics, add new songs to the database, occasionally copy lyrics out for bulletins or slides. Not a consumer streaming experience and not a performer's tool. The phone is often held in one hand; tasks are short and frequent.

## Product Purpose

A mobile front-end for the SongDB REST API (church worship song database). The product is LYRICS, not audio: there is no playback and must never be. Core jobs:

1. Find a song quickly (scroll or search by title).
2. Read its lyrics comfortably, fetched live from the API per song.
3. Add a new song (title + lyrics) to the database.
4. Switch app appearance (system / light / dark).

Success: finding and reading a song's lyrics takes seconds, with zero visual noise between the eyes and the words.

## Brand Personality

Calm, reverent, quiet. Feels like a well-set hymnal: generous margins, dignified typography, nothing shouting. Confidence comes from restraint, not decoration.

## Anti-references

- The previous JEMO CORE look: pure black/white, thick 2.5px crates around every element, ALL-CAPS labels everywhere. Banned.
- Music-player clichés: play buttons, progress bars, album-art grids, waveforms. There is no audio here.
- Loud dashboards: dense cards, badges, stat chips.

## Design Principles

- Lyrics are the product: every screen defers to text. Chrome recedes; reading comfort wins ties.
- Two calls, honest data: the API returns titles in the list and lyrics only per-song. Never show a song whose lyrics haven't loaded; never fake data.
- Inverted emphasis: at most one high-emphasis action per screen (the FAB on Home, Save on Add Song). Everything else is tonal or text.
- Tonal depth, no crates: hierarchy via M3 tonal elevation, never decorative borders.
- Motion only where it guides: short M3-expressive transitions, honoring Reduce Motion.

## Accessibility & Inclusion

WCAG AA minimum: text contrast >= 4.5:1, graphical elements >= 3:1. Honor platform Reduce Motion (crossfade instead of slide where feasible). Touch targets >= 48dp. Lyrics text supports system font scaling without layout breakage.
