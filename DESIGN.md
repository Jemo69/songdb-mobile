# Design

Material Human Interface Design (MHID): Material 3 Expressive component architecture under HIG restraint. Content-first, tonal elevation, one expressive accent.

## Theme Direction

Light and dark themes, both first-class. Scene: reading lyrics in a dim sanctuary or bright morning prep; the app follows the system by default. Dark is not an afterthought: same hierarchy, tonal surfaces instead of pure black.

## Color Palette

Strategy: restrained. Neutral tonal surfaces carry ~95% of the UI. One expressive hue (deep prayer-book teal) reserved for primary CTA, selected state, and focus. No decorative color anywhere.

| Token | Light | Dark | Role |
|---|---|---|---|
| `mh.sys.color.surface` | `#F7F9F8` | `#0E1513` | Scaffold background |
| surface container low | `#F1F5F3` | `#161D1B` | List resting cards (elev.level.1) |
| surface container high | `#E6ECEA` | `#202826` | Search field, sheets (elev.level.2) |
| `mh.sys.color.primary` | `#22635B` | `#8CD5C8` | Filled button, selected state |
| on-primary | `#FFFFFF` | `#06201C` | Text/icon on primary |
| secondary container | `#D4E8E2` | `#334B46` | Selected list tile fill, chips |
| on-secondary-container | `#07201C` | `#D4E8E2` | Its text |
| `mh.sys.color.on-surface` | `#191D1C` | `#E1E3E1` | Titles, lyrics body |
| on-surface-variant | `#404947` | `#BFC9C5` | Subtitles, metadata |
| outline-variant | `#C3CDC9` | `#3F4845` | Hairline dividers only |
| error | `#A63A32` | `#F2B8B0` | Destructive/error only |

All pairs verified >= AA for their usage. Tertiary color prohibited in this app.

## Typography

One family: Roboto (platform default, zero load). Hierarchy through scale + weight:

| Role | Size / Weight | Use |
|---|---|---|
| Headline small | 24 / w400 | Song title on lyrics screen |
| Title medium | 16 / w600 | List item titles |
| Body large | 17 / w400, height 1.7 | Lyrics body (the product) |
| Body medium | 14 / w400 | Supporting text |
| Label medium | 12 / w500, +0.4 tracking | Sparse uppercase eyebrows (max 1/screen) |

Sentence case everywhere except sparse labels. No all-caps titles or buttons.

## Shape

Unified radii scale: `mh.shape.corner.s`=10dp (chips, text fields), `.m`=16dp (cards, sheets, dialog), `.l`=28dp (FAB, search bar). Full round reserved for FAB.

## Elevation & Depth

Tonal layering only; shadows only on dialogs/scrim per M3. At rest: level 0 scaffold, level 1 cards (+2% tone), level 2 search field/sheets. No drop shadows on lists or buttons.

## Motion

M3 Expressive curves: enter 250ms decelerate, exit 150ms accelerate, feedback 200ms expressive. Page transitions are shared-axis X slides. Reduce Motion: crossfade, no slide. Lyrics screen fades content in once loaded; no stagger reflex.

## Components

- **Song list tile**: full-width, 72dp min height, tonal container-low fill, 16dp radius, title + artist-from-title suffix parsed after " - ", chevron trailing. Selected/searched state uses secondary-container.
- **Search bar**: elevated container-high pill, leading search icon, clear trailing icon when active.
- **Lyrics view**: title block, thin divider, lyrics in body-large at max 68ch measure, generous top/bottom padding. Copy action as icon button in app bar.
- **App bar**: surface-tinted, center-left title, text/icon actions only.
- **FAB**: single, bottom-end, 28dp radius, primary container, "Add song".
- **Buttons**: Save = filled (the one critical action); Cancel = text button.
- **Settings**: grouped tonal list, segmented control pattern for theme choice.

## Iconography

Rounded Material Symbols style, stroke-consistent with type. Custom launcher icon: Material You style — simple geometric mark (open book / page with lines) on flat primary-toned background, monochrome-friendly, adaptive foreground safe zone respected.
