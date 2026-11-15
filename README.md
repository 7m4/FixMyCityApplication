# FixMyCity Application

**FixMyCity** is a Flutter application that helps citizens report city issues and follow their progress. The interface follows the official Figma design and supports Arabic right-to-left (RTL) layouts.

## Project structure

The app uses a simple **feature-first** structure. Each feature keeps its screens and the widgets used only by those screens together.

```text
lib/
├── core/
│   ├── theme/                 # App colors, text styles and theme
│   ├── utils/                 # Small reusable helper functions
│   ├── testing/               # Helpers for loading local test JSON
│   └── widgets/               # Widgets shared by more than one feature
│
├── features/
│   ├── splash/
│   ├── onboarding/
│   ├── authentication/
│   ├── home/
│   ├── reports/
│   ├── create_report/
│   └── notifications/
│
└── main.dart

test_data/                     # Local JSON fixtures; kept outside lib/
├── reports.json
├── large_reports.json
├── empty_reports.json
├── notifications.json
└── categories.json
```

A feature can grow into this structure when it needs it:

```text
feature_name/
├── data/                      # Models and data sources, when needed
├── logic/                     # Cubit/Bloc, only when state becomes shared or complex
└── presentation/
    ├── screens/               # Full pages shown to the user
    └── widgets/               # Widgets used only by this feature
```

Do not create empty folders or extra layers just to follow a pattern. Add them when the feature needs them.

## Where should a file go?

- A complete page goes in that feature's `presentation/screens/` folder.
- A widget used by multiple screens in the same feature goes in `presentation/widgets/`.
- A widget used by different features goes in `core/widgets/`.
- A small helper used across the app goes in `core/utils/`.
- A Cubit belongs to the feature whose state it manages. Do not create a Cubit for every screen or button.
- Keep JSON test data in `test_data/`; do not put sample records inside screen widgets.

## State management decision

Keep simple, local interactions in Flutter's built-in `setState`. Use **Cubit** when multiple widgets or screens need to share state, when data loading has clear loading/success/error states, or when a multi-step flow needs to preserve values between pages. Use full Bloc only if the event-based approach is genuinely useful.

This keeps the code approachable for Flutter beginners and avoids adding architecture before it is needed.

## Local test data

The JSON files in `test_data/` are sample data for checking layouts:

- `reports.json`: a small list for normal display.
- `large_reports.json`: many records and different description lengths for scrolling and text wrapping.
- `empty_reports.json`: an empty list for the no-results state.
- `notifications.json`: read and unread notifications.
- `categories.json`: report categories and their departments.

Load these files with `TestDataLoader` in `lib/core/testing/test_data_loader.dart`. Screens should receive data; they should not read JSON files directly.

These fixtures are not real user data and are not a backend. Replace the data source with an API repository when the backend is ready.

## Design and implementation rules

1. Treat the Figma file as the source of truth for screens and visual styling.
2. Keep widgets small and give classes and methods clear names.
3. Prefer straightforward Flutter code over clever abstractions.
4. Add short comments when the reason for a step is not obvious.
5. Handle long lists, long text, empty data and loading/error states.
6. Keep Arabic screens RTL; use LTR direction only for values such as email addresses or phone numbers when appropriate.
