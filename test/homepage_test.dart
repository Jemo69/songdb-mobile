import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:songdb_mobile/api/songdb.dart';
import 'package:songdb_mobile/page/homepage.dart';

SongDbApi _api(List<Map<String, dynamic>> songs) {
  return SongDbApi(
    client: MockClient((request) async {
      if (request.url.path == '/api/songs') {
        return http.Response(
          jsonEncode({'songs': songs}),
          200,
          headers: {'content-type': 'application/json'},
        );
      }
      final id = request.url.pathSegments.last;
      final match = songs.where((s) => s['id'] == id).firstOrNull;
      if (match == null) return http.Response('{"message":"not found"}', 404);
      return http.Response(
        jsonEncode({'id': id, 'title': match['title'], 'lyrics': 'Line one\nLine two'}),
        200,
      );
    }),
    baseUrl: 'http://test',
    apiKey: '',
  );
}

void main() {
  testWidgets('homepage shows song titles from API', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(api: _api([
        {'id': 'a1', 'title': 'Victory - Eben'},
      ])),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Victory'), findsOneWidget);
    expect(find.text('Eben'), findsOneWidget);
  });

  testWidgets('tapping a song opens lyrics fetched by id', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(api: _api([
        {'id': 'a1', 'title': 'You are alpha'},
      ])),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('You are alpha'));
    await tester.pumpAndSettle();
    expect(find.text('Line one\nLine two'), findsOneWidget);
  });
}
