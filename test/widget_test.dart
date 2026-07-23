import 'package:flutter_test/flutter_test.dart';
import 'package:praki/app.dart';
import 'package:praki/core/di/injection_container.dart' as di;
void main() {
  testWidgets('Dashboard renders successfully test', (WidgetTester tester) async {
    // Initialize dependency injection for the test environment
    await di.init();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the brand header title is displayed
    expect(find.text('praki'), findsOneWidget);
  });
}
