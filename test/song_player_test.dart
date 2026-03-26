import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:songdb_mobile/page/song_player.dart';

void main() {
  testWidgets('SongPlayerPage displays title', (WidgetTester tester) async {
    final song = {'title': 'Amazing Grace', 'lyrics': 'How sweet the sound'};
    await tester.pumpWidget(MaterialApp(home: SongPlayerPage(song: song)));
    expect(find.text('Amazing Grace'), findsOneWidget);
  });

  testWidgets('SongPlayerPage displays lyrics', (WidgetTester tester) async {
    final song = {'title': 'Amazing Grace', 'lyrics': 'How sweet the sound'};
    await tester.pumpWidget(MaterialApp(home: SongPlayerPage(song: song)));
    expect(find.text('How sweet the sound'), findsOneWidget);
  });

  testWidgets('SongPlayerPage shows no lyrics message', (
    WidgetTester tester,
  ) async {
    final song = {'title': 'Test Song'};
    await tester.pumpWidget(MaterialApp(home: SongPlayerPage(song: song)));
    expect(find.text('No lyrics available'), findsOneWidget);
  });
}
