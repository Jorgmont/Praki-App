import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  // Ensure Flutter engine is initialized before running dependency injection
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the dependency injection container (GetIt)
  await di.init();

  runApp(const MyApp());
}
