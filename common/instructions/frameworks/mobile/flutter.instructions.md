---
applyTo: 'flutter, dart'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Flutter 3+ with Dart and modern mobile development'
---

# Flutter Framework Instructions for AI Agents

## When to Use Flutter

Use Flutter when you need:

- Single codebase for iOS, Android, web, desktop, and embedded platforms
- High-performance mobile apps with native-like user interfaces
- Consistent UI across all platforms with pixel-perfect control
- Fast development with hot reload and excellent tooling
- Custom animations and complex UI designs
- Apps requiring 60fps performance and smooth animations
- Team wanting to learn a modern, growing ecosystem

## When to Avoid Flutter

Consider alternatives when:

- Need extensive platform-specific integrations (consider native development)
- Working with legacy code that requires deep platform integration
- Team has no experience with Dart language
- App requires minimal UI and maximum platform-specific functionality
- Budget allows for separate native development teams
- Need immediate access to latest platform APIs (may have delays in Flutter)

## Framework Overview

- **Framework**: Flutter 3.x
- **Type**: UI toolkit for cross-platform applications
- **Architecture**: Widget-based declarative UI with Dart runtime
- **Language**: Dart 3.0+
- **Use Cases**: Mobile apps, web apps, desktop applications, embedded systems

## Installation & Setup

### ✅ Recommended: Flutter SDK Installation

```bash
# macOS installation with Homebrew
brew install --cask flutter

# Manual installation
# Download Flutter SDK from https://flutter.dev/docs/get-started/install
# Extract and add to PATH

# Verify installation
flutter doctor

# Create new project
flutter create my_app
cd my_app

# Run on device/simulator
flutter run

# Run on specific platform
flutter run -d chrome      # Web
flutter run -d macos       # macOS
flutter run -d windows     # Windows
```

### ✅ Development Environment Setup

```bash
# Install platform dependencies
# For iOS (macOS only)
xcode-select --install

# For Android
# Install Android Studio or Android SDK

# Verify setup
flutter doctor --verbose

# Install VS Code extensions
code --install-extension Dart-Code.flutter
code --install-extension Dart-Code.dart-code
```

### AI Agent Decision Tree

- **For mobile-first apps**: Start with iOS/Android, expand to other platforms
- **For web apps**: Consider if Flutter web meets your SEO/performance needs
- **For desktop**: Evaluate against native solutions (Electron, .NET, etc.)
- **For prototyping**: Flutter's hot reload provides excellent rapid development

## Project Structure

### ✅ Standard Flutter Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart           # App entry point
│   ├── models/             # Data models
│   │   ├── user.dart
│   │   └── product.dart
│   ├── screens/            # Screen widgets
│   │   ├── home_screen.dart
│   │   ├── profile_screen.dart
│   │   └── login_screen.dart
│   ├── widgets/            # Reusable widgets
│   │   ├── custom_button.dart
│   │   ├── user_card.dart
│   │   └── loading_spinner.dart
│   ├── services/           # Business logic and API calls
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   └── storage_service.dart
│   ├── providers/          # State management (if using Provider)
│   │   ├── user_provider.dart
│   │   └── theme_provider.dart
│   ├── utils/              # Utility functions
│   │   ├── constants.dart
│   │   ├── helpers.dart
│   │   └── validators.dart
│   └── themes/             # App theming
│       ├── app_theme.dart
│       └── colors.dart
├── test/                   # Unit and widget tests
├── integration_test/       # Integration tests
├── assets/                 # Images, fonts, etc.
├── android/               # Android-specific code
├── ios/                   # iOS-specific code
├── web/                   # Web-specific code
├── pubspec.yaml          # Dependencies and metadata
└── analysis_options.yaml # Dart analyzer configuration
```

## Core Concepts

### Widgets and State Management

✅ **Best Practice**: Stateless and Stateful widgets with proper state management

```dart
// models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
```

```dart
// widgets/user_card.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool loading;

  const UserCard({
    Key? key,
    required this.user,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (loading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        onEdit?.call();
                        break;
                      case 'delete':
                        _showDeleteDialog(context);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete?.call();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
```

### State Management with Provider

✅ **Best Practice**: Provider pattern for state management

```dart
// providers/user_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService;

  List<User> _users = [];
  bool _loading = false;
  String? _error;

  UserProvider(this._apiService);

  List<User> get users => _users;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _setLoading(true);
    _setError(null);

    try {
      _users = await _apiService.getUsers();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addUser(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      final newUser = await _apiService.createUser(user);
      _users.add(newUser);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      final updatedUser = await _apiService.updateUser(user);
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUser(String userId) async {
    _setLoading(true);
    _setError(null);

    try {
      await _apiService.deleteUser(userId);
      _users.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
```

### Navigation and Routing

✅ **Best Practice**: Named routes with go_router

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'providers/user_provider.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return ProfileScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            Provider.of<ApiService>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
```

### HTTP Requests and Error Handling

✅ **Best Practice**: Structured API service with error handling

```dart
// services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message';
}

class ApiService {
  static const String baseUrl = 'https://api.example.com';
  static const Duration timeout = Duration(seconds: 30);

  Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/users'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw ApiException(
          'Failed to fetch users',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } on http.ClientException {
      throw ApiException('Network error occurred');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<User> createUser(User user) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/users'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw ApiException(
          'Failed to create user',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/users/${user.id}'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw ApiException(
          'Failed to update user',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$baseUrl/users/$userId'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      if (response.statusCode != 204) {
        throw ApiException(
          'Failed to delete user',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }
}
```

## Best Practices

### ✅ Do's

- Use `const` constructors for widgets whenever possible
- Implement proper state management (Provider, Bloc, Riverpod)
- Use `ListView.builder` for long lists instead of `Column` with `SingleChildScrollView`
- Handle all possible states (loading, error, empty, success)
- Implement proper error boundaries and user feedback
- Use proper naming conventions (camelCase for variables, PascalCase for classes)
- Test widgets, logic, and integration scenarios
- Use `SafeArea` for proper screen boundary handling

### ❌ Don'ts

- Don't ignore Flutter doctor warnings
- Don't use `setState` for complex state management
- Don't forget to dispose controllers and streams
- Don't use hardcoded values for responsive design
- Don't ignore accessibility features
- Don't block the UI thread with heavy computations
- Don't forget to handle keyboard appearance on forms
- Don't ignore platform-specific design guidelines

### Performance Optimization

```dart
// utils/performance_helpers.dart
import 'package:flutter/material.dart';

class PerformanceOptimizedList extends StatelessWidget {
  final List<dynamic> items;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool shrinkWrap;

  const PerformanceOptimizedList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: shrinkWrap,
      physics: const AlwaysScrollableScrollPhysics(),
      cacheExtent: 200.0, // Cache items for smooth scrolling
      itemBuilder: itemBuilder,
    );
  }
}

// Memoization for expensive calculations
class MemoizedWidget extends StatelessWidget {
  final String data;

  const MemoizedWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildExpensiveWidget();
  }

  Widget _buildExpensiveWidget() {
    // Use compute() for heavy operations
    return FutureBuilder<String>(
      future: _processDataInBackground(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<String> _processDataInBackground() async {
    return await compute(_expensiveFunction, data);
  }

  static String _expensiveFunction(String data) {
    // Heavy computation here
    return data.toUpperCase();
  }
}
```

## Development Workflow

### ✅ Recommended Development Setup

```bash
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
```

### IDE Configuration

- **VS Code Extensions**: Flutter, Dart, Flutter Widget Snippets
- **Android Studio**: Flutter and Dart plugins
- **Settings**: Enable hot reload, format on save, show performance overlay

### AI Agent Decision Matrix

| Scenario      | Recommended Approach             | Avoid                            |
| ------------- | -------------------------------- | -------------------------------- |
| Simple state  | StatefulWidget + setState        | Complex state management         |
| Complex state | Provider/Bloc/Riverpod           | setState for global state        |
| Navigation    | go_router or Navigator 2.0       | Legacy Navigator 1.0             |
| HTTP requests | http package with error handling | dio for simple apps              |
| Local storage | shared_preferences/sqflite       | Complex database for simple data |
| Animations    | AnimatedWidget/Controller        | Heavy third-party packages       |
| Testing       | flutter_test + integration       | Manual testing only              |

## Integration Guidelines

- **With APIs**: Use proper HTTP client with error handling and timeouts
- **With databases**: Use sqflite for local storage, Firebase for cloud
- **With authentication**: Implement secure token storage and validation
- **With push notifications**: Use Firebase Cloud Messaging
- **With analytics**: Integrate Firebase Analytics or similar
- **With crash reporting**: Use Firebase Crashlytics for production apps

## Testing

### ✅ Widget Testing

```dart
// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/widgets/user_card.dart';
import 'package:my_app/models/user.dart';

void main() {
  group('UserCard Widget Tests', () {
    testWidgets('displays user information correctly', (tester) async {
      const user = User(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserCard(user: user),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      const user = User(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserCard(
              user: user,
              onTap: () => wasTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(UserCard));
      expect(wasTapped, isTrue);
    });
  });
}
```

### ✅ Integration Testing

```dart
// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('complete user flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify home screen loads
      expect(find.text('Home'), findsOneWidget);

      // Navigate to users screen
      await tester.tap(find.text('Users'));
      await tester.pumpAndSettle();

      // Verify users list
      expect(find.byType(ListView), findsOneWidget);

      // Test user interaction
      if (find.byType(UserCard).evaluate().isNotEmpty) {
        await tester.tap(find.byType(UserCard).first);
        await tester.pumpAndSettle();
      }
    });
  });
}
```

## Security Considerations

- Store sensitive data securely using flutter_secure_storage
- Validate all user inputs and sanitize data
- Use HTTPS for all network requests
- Implement proper authentication and authorization
- Obfuscate code for production releases
- Use certificate pinning for critical APIs
- Handle biometric authentication securely
- Implement proper session management

## Error Handling

```dart
// utils/error_handler.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ErrorHandler {
  static void showError(BuildContext context, dynamic error) {
    String message;

    if (error is ApiException) {
      message = error.message;
    } else {
      message = 'An unexpected error occurred';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static Widget buildErrorWidget(String message, {VoidCallback? onRetry}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
```

## AI Agent Quick Reference

- **Project Setup**: Use `flutter create` with appropriate template for target platforms
- **Widget Development**: Focus on composition, const constructors, and proper state management
- **State Management**: Use Provider for medium complexity, Bloc for complex apps
- **Navigation**: Implement declarative routing with go_router
- **Data Fetching**: Use http package with proper error handling and loading states
- **Performance**: Use ListView.builder, const widgets, and compute for heavy operations
- **Testing**: Write widget tests, unit tests, and integration tests
- **Deployment**: Use `flutter build` for platform-specific releases

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- [Coding conventions specific to this framework]
- Use consistent naming: camelCase for variables, PascalCase for classes
- Prefix private variables with underscore (_privateVariable)
- Use descriptive names for widgets and functions
- Follow Dart package naming conventions (lowercase with underscores)
- Organize imports: Dart SDK, Flutter SDK, third-party packages, local files

### Architecture Patterns

- **BLoC Pattern**: Business Logic Component for scalable state management
- **MVVM Pattern**: Model-View-ViewModel with Provider or Riverpod
- **Clean Architecture**: Separate data, domain, and presentation layers
- **Repository Pattern**: Abstract data access and API interactions
- **Dependency Injection**: Use GetIt, injectable, or Riverpod for DI
- **Feature-First Organization**: Group files by feature rather than type

## Integration Points

### Firebase Integration

- **Purpose**: Backend services, authentication, analytics, and cloud storage
- **Setup**: `flutter pub add firebase_core firebase_auth cloud_firestore`
- **Usage**: 
  ```dart
  await Firebase.initializeApp();
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  ```

### API Integration (HTTP/REST)

- **Purpose**: Communicate with REST APIs and web services
- **Setup**: `flutter pub add http dio retrofit json_annotation`
- **Usage**: 
  ```dart
  final response = await http.get(Uri.parse('https://api.example.com/data'));
  final data = json.decode(response.body);
  ```

### Local Storage Integration

- **Purpose**: Persist data locally using SQLite, Hive, or shared preferences
- **Setup**: `flutter pub add sqflite hive shared_preferences`
- **Usage**: 
  ```dart
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('key', 'value');
  ```

### Native Platform Integration

- **Purpose**: Access platform-specific features through method channels
- **Setup**: Configure platform channels in android/ and ios/ directories
- **Usage**: 
  ```dart
  static const platform = MethodChannel('com.example.app/battery');
  final batteryLevel = await platform.invokeMethod('getBatteryLevel');
  ```

## Version Compatibility

- **Flutter SDK**: 3.16+ (latest stable recommended)
- **Dart SDK**: 3.2+ (comes with Flutter)
- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 12.0+ 
- **Web**: Modern browsers (Chrome 84+, Safari 14+, Firefox 72+)
- **Desktop**: Windows 10+, macOS 10.14+, Linux (Ubuntu 18.04+)

## Troubleshooting

### Debug Mode

```bash
# Run app in debug mode
flutter run --debug

# Enable verbose logging
flutter run --verbose

# Profile performance
flutter run --profile

# Analyze code
flutter analyze

# Check doctor for setup issues
flutter doctor -v
```

### Log Analysis

- **Console logs**: Use `print()` statements or `debugPrint()` for debug output
- **Flutter Inspector**: Use DevTools for widget tree inspection
- **Performance**: Monitor frame rendering and memory usage in DevTools
- **Crash logs**: Check platform-specific crash reports (Crashlytics, Bugsnag)

### Common Error Messages

- **Error**: `RenderFlex overflowed by X pixels`
  **Cause**: Widget content exceeds available space
  **Solution**: Wrap with `Expanded`, `Flexible`, or `SingleChildScrollView`

- **Error**: `setState() called after dispose()`
  **Cause**: Attempting to update state on a disposed widget
  **Solution**: Check `mounted` property before calling `setState()`

- **Error**: `A RenderFlex overflowed by X pixels on the right`
  **Cause**: Row widget children exceed horizontal space
  **Solution**: Use `Expanded` widgets or reduce content size

- **Error**: `Could not resolve all artifacts for configuration ':app:debugRuntimeClasspath'`
  **Cause**: Gradle dependency resolution issues
  **Solution**: Run `flutter clean` and `flutter pub get`, check gradle version compatibility
