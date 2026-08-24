import 'package:flutter/material.dart';

import '../api/songdb.dart';
import '../models/song.dart';
import '../theme/mhts.dart';
import 'lyrics_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.api});

  final SongDbApi api;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Song>> _songsFuture;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _songsFuture = widget.api.listSongs();
  }

  void _reload() {
    setState(() => _songsFuture = widget.api.listSongs());
  }

  void _openSong(Song song) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: MhMotion.enter,
        reverseTransitionDuration: MhMotion.exit,
        pageBuilder: (_, _, _) => LyricsPage(song: song, api: widget.api),
        transitionsBuilder: (context, animation, reverseAnimation, child) {
          if (_reduceMotion) {
            return FadeTransition(opacity: animation, child: child);
          }
          final slide = Tween(
            begin: const Offset(0.06, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
          return SlideTransition(
            position: slide,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );
  }

  bool get _reduceMotion =>
      MediaQuery.of(context).disableAnimations;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SongDB'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/add_song'),
        icon: const Icon(Icons.add),
        label: const Text('Add song'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: SearchBar(
                hintText: 'Search songs',
                leading: Icon(Icons.search, color: scheme.onSurfaceVariant),
                trailing: _query.isEmpty
                    ? null
                    : [
                        IconButton(
                          tooltip: 'Clear search',
                          icon: const Icon(Icons.close),
                          onPressed: () => setState(() => _query = ''),
                        ),
                      ],
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(
                  scheme.surfaceContainerHigh,
                ),
                constraints: const BoxConstraints(minHeight: 52),
              ),
            ),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<Song>>(
      future: _songsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _ErrorState(message: snapshot.error.toString(), onRetry: _reload);
        }
        final songs = snapshot.data ?? const <Song>[];
        final filtered = _query.isEmpty
            ? songs
            : songs
                .where((s) => s.title.toLowerCase().contains(_query.toLowerCase()))
                .toList();

        if (songs.isEmpty) {
          return _EmptyState(onAdd: () => Navigator.pushNamed(context, '/add_song'));
        }
        if (filtered.isEmpty) {
          return _NoResultsState(query: _query);
        }
        return RefreshIndicator(
          onRefresh: () async => _reload(),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final song = filtered[index];
              final parsed = song.parsedTitle;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(Mh.cornerM),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Mh.cornerM),
                    onTap: () => _openSong(song),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parsed.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                if (parsed.artist != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      parsed.artist!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded,
                size: 40, color: scheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('Could not reach SongDB', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu_book_outlined,
                size: 40, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('The database is empty', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Add your first song to start the library.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(onPressed: onAdd, child: const Text('Add a song')),
          ],
        ),
      ),
    );
  }
}

class _NoResultsState extends StatelessWidget {
  const _NoResultsState({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded,
                size: 40, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('No match for "$query"',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Check the spelling or try a shorter search.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
