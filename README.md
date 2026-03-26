# JEMO CORE - SongDB Mobile

A high-impact, tactical mobile interface for the SongDB ecosystem, built on the **JEMO CORE** design language.

## 2. Core Philosophy: "The Tactical Monolith"
Jemo Core is defined by three pillars:
* **Binary Contrast**: We communicate in absolutes. If it's not Black (#000000), it's White (#FFFFFF). Gray is a utility, not a personality.
* **Hard Containment**: Every element lives in a defined space. We do not use whitespace alone to separate content; we use thick, deliberate borders to "crate" information.
* **Softened Industrial**: While our contrast is harsh, our geometry is approachable. We use consistent rounded corners to prevent the interface from feeling too aggressive or sharp.

## Visual Specifications
### The "Onyx" Palette
* **True Black**: #000000. Used for Navbars, Sidebars, Modals, and Primary Buttons.
* **Stark White**: #FFFFFF. Used for text on black backgrounds and the defining 2px-3px borders.

### Typography: "Loud & Clear"
* **Headers & Labels**: All structural text (Nav items, Button labels, Modal headers) is UPPERCASE and BOLD.
* **Body Copy**: Sentence case is reserved strictly for user feedback and descriptions.

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio / VS Code with Flutter extension

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Create a `.env` file based on `.env.example`:
   ```bash
   cp .env.example .env
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Environment Variables
The application requires the following environment variables in a `.env` file:
- `BASE_URL`: The URL of the SongDB API.
- `API_KEY`: Your authentication key for the API.

## Design Implementation
The JEMO CORE design is implemented in `lib/theme/jemo_core.dart`. 
Key features:
- Border Radius: 10px
- Border Width: 2.5px
- High-contrast inversion for active states.
