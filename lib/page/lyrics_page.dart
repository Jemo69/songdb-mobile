import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/songdb.dart';
import '../models/song.dart';

/// The product screen: a song's lyrics, fetched live by id.
class LyricsPage extends StatefulWidget {
  const LyricsPage({super.key, required this.song, required this.api});

  final Song song;
  final SongDbApi api;

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  late Future<Song> _future;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _future = widget.api.getSong(widget.song.id);
  }

  void _reload() => setState(() => _future = widget.api.getSong(widget.song.id));

  Future<void> _copyLyrics(String lyrics) async {
    await Clipboard.setData(ClipboardData(text: lyrics));
    if (!mounted) return;
    setState(() => _copied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lyrics copied')),
    );
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final parsed = widget.song.parsedTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(parsed.title),
        actions: [
          FutureBuilder<Song>(
            future: _future,
            builder: (context, snapshot) {
              final lyrics = snapshot.data?.lyrics;
              if (lyrics == null || lyrics.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Copy lyrics',
                icon: Icon(_copied ? Icons.check : Icons.copy_outlined),
                onPressed: () => _copyLyrics(lyrics),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<Song>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done &&
                !snapshot.hasData) {
              return _LoadingState(title: parsed.title);
            }
            if (snapshot.hasError) {
              return _ErrorState(error: snapshot.error!, onRetry: _reload);
            }
            final song = snapshot.data!;
            final lyrics = song.lyrics ?? '';
            if (lyrics.isEmpty) {
              return _NoLyricsState();
            }
            return RefreshIndicator(
              onRefresh: () async => _reload(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (parsed.artist != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(parsed.artist!,
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: SelectableText(
                        lyrics,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // Skeleton lines hold the lyric page's shape while fetching.
    final shimmer = Theme.of(context).colorScheme.surfaceContainerHigh;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 14,
            decoration: BoxDecoration(
              color: shimmer,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          const SizedBox(height: 20),
          for (final w in const [1.0, 0.85, 0.95, 0.6, 0.9, 0.75])
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                height: 13,
                width: MediaQuery.of(context).size.width * w * 0.82,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is ApiException ? error.toString() : 'Network error';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 40, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('Could not load lyrics',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

class _NoLyricsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.subject_rounded,
                size: 40, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('No lyrics yet', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'This song exists in the database but has no lyrics stored.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
