import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../logger.dart';

class AddSongPage extends StatefulWidget {
  const AddSongPage({super.key});

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  final titleController = TextEditingController();
  final lyricsController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  void addSong(String title, String lyrics) async {
    try {
      final String baseUrl =
          dotenv.env['BASE_URL'] ?? 'https://songdb-swart.vercel.app';
      final String apiKey = dotenv.env['API_KEY'] ?? '';

      final url = '$baseUrl/api/songs';
      logger.i('Adding song: $title');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (apiKey.isNotEmpty) "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({"title": title, "lyrics": lyrics}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Song added successfully');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Song added successfully!")),
        );
        Navigator.pop(context);
      } else {
        logger.e('Failed to add song: ${response.statusCode}');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add song: ${response.body}")),
        );
      }
    } catch (e) {
      logger.e('Error adding song', error: e);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ADD NEW SONG")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hierarchy: Content First
            const Text(
              "NEW SONG",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "TITLE",
                hintText: "ENTER SONG TITLE",
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: lyricsController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: "LYRICS",
                hintText: "ENTER SONG LYRICS",
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 48),
            // Inverted Emphasis Hierarchy: Filled for critical action
            FilledButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  addSong(titleController.text, lyricsController.text);
                }
              },
              child: const Text("SAVE SONG"),
            ),
            const SizedBox(height: 16),
            // Outlined for medium emphasis
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
          ],
        ),
      ),
    );
  }
}
