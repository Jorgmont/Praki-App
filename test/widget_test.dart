import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_app/app.dart';
import 'package:flutter_clean_app/core/di/injection_container.dart' as di;

void main() {
  testWidgets('Dashboard renders successfully test', (WidgetTester tester) async {
    // Initialize dependency injection for the test environment
    await di.init();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the main AppBar title is displayed
    expect(find.text('Workspace Analítico'), findsOneWidget);
  });
}
