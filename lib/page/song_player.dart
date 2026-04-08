import 'package:flutter/material.dart';

class SongPlayerPage extends StatelessWidget {
  final Map<String, dynamic> song;

  const SongPlayerPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final title = (song['title'] ?? song['name'] ?? song['song_title'] ?? '')
        .toString()
        .toUpperCase();
    final lyrics = song['lyrics'] ?? song['text'] ?? song['content'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('VIEW SONG')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Content-First: Generous negative space and subtle tonal layering
            Center(
              child: Text(
                title.isNotEmpty ? title : 'UNKNOWN TITLE',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            if (lyrics.toString().isNotEmpty) ...[
              const Text(
                'LYRICS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Subtle tonal layering instead of heavy borders/shadows
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  lyrics.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ] else
              const Padding(
                padding: EdgeInsets.all(48.0),
                child: Text(
                  'NO LYRICS AVAILABLE',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 48),
            // Inverted Emphasis Hierarchy: Outlined for medium emphasis
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ],
        ),
      ),
    );
  }
}
