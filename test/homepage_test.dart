import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:songdb_mobile/page/homepage.dart';

void main() {
  testWidgets('Homepage displays title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));
    expect(find.text('SongDB'), findsOneWidget);
  });

  testWidgets('Homepage has add song button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
