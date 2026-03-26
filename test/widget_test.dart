import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:songdb_mobile/page/homepage.dart';

void main() {
  testWidgets('App shows SongDB title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));
    expect(find.text('SongDB'), findsOneWidget);
  });

  testWidgets('App has add button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
