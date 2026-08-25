# SongDB Mobile

A lyrics-first mobile client for the SongDB API, built with Flutter on the
MHID (Material Human Interface Design) system: M3 Expressive components under
HIG restraint. This app reads and writes song lyrics. There is no audio
playback and there never will be.

## Features

- Browse songs from the SongDB API (`GET /api/songs`), with search
- Read a song's lyrics, fetched live per song (`GET /api/songs/{id}`)
- Add new songs to the database (`POST /api/songs`)
- Copy lyrics to the clipboard
- System / light / dark theme
- Material You adaptive launcher icon with themed (monochrome) support

## Design

MHID design language, tokenized in `lib/theme/mhts.dart`:

- Tonal surfaces, no decorative borders (the old JEMO CORE "crate" look is gone)
- One restrained teal seed color; expressive color only on primary actions
- Inverted emphasis hierarchy: one high-emphasis action per screen
- M3 Expressive motion at short durations; honors Reduce Motion

Strategic context: `PRODUCT.md`. Visual system: `DESIGN.md`.
Icon source: `design/icon.svg` (foreground + monochrome variants).

## Getting Started

Prerequisites: Flutter SDK.

```bash
flutter pub get
cp .env.example .env   # then fill in your API key
flutter run
```

## Environment Variables

`.env` (gitignored) requires:

- `BASE_URL`: the SongDB API base URL
- `API_KEY`: your bearer auth key

CI uses `.env.example` as a placeholder so asset bundling succeeds.

## Architecture

```
lib/
  api/songdb.dart      # SongDbApi client (list / get by id / create)
  models/song.dart     # Song model, artist parsing from "Title - Artist"
  theme/mhts.dart      # MHID token system -> ThemeData
  page/homepage.dart   # search + song list
  page/lyrics_page.dart# lyrics view (fetch by id, copy, skeleton)
  page/add_song.dart   # create song form
  page/settings.dart   # theme selection
```

## CI

`.github/workflows/android.yml` builds a release APK on every push to main
and uploads it as the `songdb-apk` artifact.
