import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:songdb_mobile/api/songdb.dart';
import 'package:songdb_mobile/page/add_song.dart';

void main() {
  SongDbApi makeApi() => SongDbApi(
        client: MockClient((request) async {
          expect(request.method, 'POST');
          return http.Response(
            '{"id": "new-1", "title": "Test song", "lyrics": "Words"}',
            201,
          );
        }),
        baseUrl: 'http://test',
        apiKey: '',
      );

  testWidgets('AddSongPage validates empty title', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddSongPage(api: makeApi())));
    await tester.tap(find.text('Save song'));
    await tester.pump();
    expect(find.text('Give the song a title'), findsOneWidget);
  });

  testWidgets('AddSongPage saves and pops', (tester) async {
    var saved = false;
    await tester.pumpWidget(MaterialApp(
      home: AddSongPage(
        api: makeApi(),
        onSaved: (_) => saved = true,
      ),
    ));
    await tester.enterText(find.byType(TextFormField).at(0), 'Test song');
    await tester.enterText(find.byType(TextFormField).at(1), 'Words');
    await tester.tap(find.text('Save song'));
    await tester.pumpAndSettle();
    expect(saved, isTrue);
  });
}
