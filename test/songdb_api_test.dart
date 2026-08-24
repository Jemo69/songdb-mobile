import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:songdb_mobile/api/songdb.dart';
import 'package:songdb_mobile/models/song.dart';

void main() {
  group('SongDbApi.listSongs', () {
    test('parses {songs: [...]} envelope', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/songs');
        expect(request.headers['Authorization'], 'Bearer test-key');
        return http.Response(
          jsonEncode({
            'songs': [
              {'id': 'a1', 'title': 'Victory - Eben'},
              {'id': 'b2', 'title': 'Arise - Don Moen'},
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });
      final api = SongDbApi(client: client, baseUrl: 'http://test', apiKey: 'test-key');
      final songs = await api.listSongs();
      expect(songs.length, 2);
      expect(songs.first.title, 'Victory - Eben');
      expect(songs.first.lyrics, isNull);
    });

    test('throws ApiException on non-200', () async {
      final api = SongDbApi(
        client: MockClient((request) async => http.Response('nope', 500)),
        baseUrl: 'http://test',
        apiKey: '',
      );
      expectLater(api.listSongs(), throwsA(isA<ApiException>()));
    });
  });

  group('SongDbApi.getSong', () {
    test('fetches lyrics by id', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/songs/abc-123');
        return http.Response(
          jsonEncode({
            'id': 'abc-123',
            'title': 'You are alpha',
            'lyrics': 'You are Alpha and Omega\nWe worship You our Lord',
          }),
          200,
        );
      });
      final api = SongDbApi(
        client: client,
        baseUrl: 'http://test',
        apiKey: 'test-key',
      );
      final song = await api.getSong('abc-123');
      expect(song.lyrics, contains('Alpha and Omega'));
    });

    test('404 becomes a friendly ApiException', () async {
      final api = SongDbApi(
        client: MockClient((request) async => http.Response('{"message":"Song not found"}', 404)),
        baseUrl: 'http://test',
        apiKey: '',
      );
      expectLater(api.getSong('missing'), throwsA(isA<ApiException>()));
    });
  });

  group('Song.parsedTitle', () {
    test('splits artist suffix', () {
      final song = Song(id: '1', title: 'Trading my sorrows - Women of faith');
      expect(song.parsedTitle.title, 'Trading my sorrows');
      expect(song.parsedTitle.artist, 'Women of faith');
    });

    test('leaves plain titles alone', () {
      final song = Song(id: '1', title: 'Hosanna in the highest');
      expect(song.parsedTitle.title, 'Hosanna in the highest');
      expect(song.parsedTitle.artist, isNull);
    });
  });
}
