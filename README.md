# FixMyCity Application

**FixMyCity** is a mobile application built with **Flutter** that empowers citizens to report and track city maintenance issues and civic problems efficiently. The project is designed with a clean, scalable **Feature-First Architecture** and full **Arabic (RTL)** support.

---

## Project Folder Structure

The codebase inside `lib/` is organized using a **Feature-First** approach, separating shared application resources (`core/`) from independent business features (`features/`):

```text
fix_my_city_application/
├── assets/                          # Static application assets
│   ├── icons/                       # SVG and PNG icons
│   └── images/                      # Logos, splash graphics, and illustrations
│
├── lib/
│   ├── core/                        # Shared utilities, styles, and reusable components
│   │   ├── constants/               # App-wide constants (API endpoints, asset paths, strings)
│   │   ├── network/                 # HTTP client configuration and API interceptors
│   │   ├── theme/                   # Centralized UI styling and branding
│   │   │   ├── app_colors.dart      # Color palette definitions
│   │   │   ├── app_text_styles.dart # Standardized typography and text styles
│   │   │   └── app_theme.dart       # Global ThemeData configuration
│   │   ├── utils/                   # Helper functions and input validation
│   │   │   └── app_validators.dart  # Reusable form field validation rules
│   │   └── widgets/                 # Reusable UI components across multiple features
│   │       ├── custom_auth_header.dart
│   │       ├── custom_primary_button.dart
│   │       ├── custom_text_field.dart
│   │       ├── step_progress_bar.dart
│   │       └── widgets.dart         # Barrel file exporting all core widgets
│   │
│   ├── features/                    # Independent application modules
│   │   ├── splash/                  # Initial loading and branding screen
│   │   │   └── presentation/
│   │   │       └── screens/
│   │   │           └── splash_screen.dart
│   │   │
│   │   ├── auth/                    # Authentication & multi-step registration
│   │   │   ├── data/                # Auth models and API repositories
│   │   │   ├── logic/               # State management for login and registration steps
│   │   │   └── presentation/
│   │   │       ├── screens/         # Login and multi-step sign-up screens
│   │   │       │   └── register_step1_screen.dart
│   │   │       └── widgets/         # Widgets exclusive to authentication screens
│   │   │
│   │   └── create_report/           # Multi-step civic issue reporting workflow
│   │       ├── data/                # Report request models and submission repositories
│   │       ├── logic/               # Shared state across the 5-step report flow
│   │       └── presentation/
│   │           ├── screens/         # Step-by-step reporting screens
│   │           └── widgets/         # Components specific to report creation
│   │
│   └── main.dart                    # Application entry point
│
├── native_screen_splash.yaml        # Configuration for native Android & iOS splash screens
└── pubspec.yaml                     # Project dependencies and asset declarations
```

---

## Folder Responsibilities

* **`assets/`**: Stores all static media files, including vector icons (`.svg`) and raster images (`.png`).
* **`lib/core/`**: Contains foundational code shared across the entire application so features remain decoupled and DRY (Don't Repeat Yourself).
  * **`theme/`**: Centralizes all visual design tokens (`AppColors`, `AppTextStyles`, and `AppTheme`) to ensure UI consistency and easy rebranding.
  * **`widgets/`**: Holds generic, reusable UI building blocks such as custom text fields, primary action buttons, and multi-step progress indicators.
  * **`utils/`**: Provides standalone helper utilities, including form validation logic (`AppValidators`).
* **`lib/features/`**: Houses self-contained business features. Each feature is divided into three layers:
  * **`data/`**: Data models and repository classes responsible for communicating with backend APIs or local storage.
  * **`logic/`**: State management controllers (e.g., Cubit/Bloc or Provider) handling business rules and temporary multi-step form data.
  * **`presentation/`**: UI screens and feature-specific widgets.

---

## Getting Started

### Prerequisites

* [Flutter SDK](https://flutter.dev) (3.x or higher)
* Dart SDK
* Android Studio / VS Code with Flutter extensions

### Installation & Running

1. **Clone the repository:**
   ```bash
   git clone https://github.com
   cd fix_my_city_application
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate native splash screens (if modified):**
   ```bash
   dart run flutter_native_splash:create --path=native_screen_splash.yaml
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## Key Packages Used

* [`flutter_svg`](https://pub.dev) — Rendering crisp vector icons and illustrations.
* [`flutter_native_splash`](https://pub.dev) — Customizing native Android and iOS launch screens.
