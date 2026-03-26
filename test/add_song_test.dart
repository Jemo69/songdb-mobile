import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:songdb_mobile/page/add_song.dart';

void main() {
  testWidgets('AddSongPage has title field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddSongPage()));
    expect(find.text('Song Title'), findsOneWidget);
  });

  testWidgets('AddSongPage has lyrics field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddSongPage()));
    expect(find.text('Lyrics'), findsOneWidget);
  });

  testWidgets('AddSongPage has save button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddSongPage()));
    expect(find.text('Save Song'), findsOneWidget);
  });
}
