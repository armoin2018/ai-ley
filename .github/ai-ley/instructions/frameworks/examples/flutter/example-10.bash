# Development
flutter run
flutter run --hot        # Enable hot reload
flutter run --debug      # Debug mode
flutter run --release    # Release mode

# Platform-specific
flutter run -d chrome    # Web
flutter run -d ios       # iOS simulator
flutter run -d android   # Android emulator

# Testing
flutter test                    # Unit tests
flutter test integration_test/ # Integration tests
flutter test --coverage       # With coverage

# Building
flutter build apk         # Android APK
flutter build ios         # iOS build
flutter build web         # Web build
flutter build macos       # macOS app

# Analysis and formatting
flutter analyze          # Static analysis
dart format .            # Code formatting
flutter pub deps         # Dependency tree