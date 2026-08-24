import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/song.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});
  @override
  String toString() => message;
}

/// Client for the SongDB REST API.
///
/// The list endpoint returns song summaries without lyrics; lyrics must be
/// fetched per song by id.
class SongDbApi {
  SongDbApi({http.Client? client, String? baseUrl, String? apiKey})
    : _client = client ?? http.Client(),
      baseUrl = (baseUrl ??
          dotenv.maybeGet('BASE_URL') ??
          'https://songdb-swart.vercel.app')
          .replaceAll(RegExp(r'/+$'), ''),
      apiKey = apiKey ?? (dotenv.maybeGet('API_KEY') ?? '');

  final http.Client _client;
  final String baseUrl;
  final String apiKey;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (apiKey.isNotEmpty) 'Authorization': 'Bearer $apiKey',
  };

  /// GET /api/songs
  Future<List<Song>> listSongs() async {
    final response = await _client
        .get(Uri.parse('$baseUrl/api/songs'), headers: _headers)
        .timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw ApiException(
        'Could not load songs (${response.statusCode})',
        statusCode: response.statusCode,
      );
    }
    final decoded = jsonDecode(response.body);
    final List<dynamic> items = decoded is List
        ? decoded
        : (decoded['songs'] ??
              decoded['data'] ??
              decoded['results'] ??
              const []) as List<dynamic>;
    return items.map((item) => Song.fromSummaryJson(item as Map<String, dynamic>)).toList();
  }

  /// GET /api/songs/{id}
  Future<Song> getSong(String id) async {
    final response = await _client
        .get(Uri.parse('$baseUrl/api/songs/$id'), headers: _headers)
        .timeout(const Duration(seconds: 20));
    if (response.statusCode == 404) {
      throw ApiException('Song not found', statusCode: 404);
    }
    if (response.statusCode != 200) {
      throw ApiException(
        'Could not load song (${response.statusCode})',
        statusCode: response.statusCode,
      );
    }
    return Song.fromJson(jsonDecode(response.body));
  }

  /// POST /api/songs
  Future<Song> createSong({required String title, required String lyrics}) async {
    final response = await _client
        .post(
          Uri.parse('$baseUrl/api/songs'),
          headers: _headers,
          body: jsonEncode({'title': title, 'lyrics': lyrics}),
        )
        .timeout(const Duration(seconds: 20));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ApiException(
        'Could not save song (${response.statusCode})',
        statusCode: response.statusCode,
      );
    }
    final decoded = jsonDecode(response.body);
    return Song.fromJson(decoded is Map<String, dynamic> ? decoded : {'title': title});
  }

  Future<void> close() async => _client.close();
}
