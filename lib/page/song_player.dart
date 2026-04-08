import 'package:flutter/material.dart';

class SongPlayerPage extends StatelessWidget {
  final Map<String, dynamic> song;

  const SongPlayerPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final title = song['title'] ?? song['name'] ?? song['song_title'] ?? '';
    final lyrics = song['lyrics'] ?? song['text'] ?? song['content'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('VIEW SONG')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title.toString().isNotEmpty
                    ? title.toString().toUpperCase()
                    : 'UNKNOWN TITLE',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            if (lyrics.toString().isNotEmpty) ...[
              const Text(
                'LYRICS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Text(
                  lyrics.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
              ),
            ] else
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.5),
                    width: 2.5,
                  ),
                ),
                child: const Text(
                  'NO LYRICS AVAILABLE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text('CLOSE'),
            ),
          ],
        ),
      ),
    );
  }
}
