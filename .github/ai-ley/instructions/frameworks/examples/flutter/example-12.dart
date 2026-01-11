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