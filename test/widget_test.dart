import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_health_app/main.dart';

void main() {
  testWidgets('SmartHealth app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartHealthApp());
    // Build our app and trigger a frame.
  });
}