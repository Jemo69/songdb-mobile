import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'song_player.dart';
import '../logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<dynamic> _songs = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchSongs();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      logger.i('App resumed, fetching songs...');
      _fetchSongs();
    }
  }

  Future<void> _fetchSongs() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final String baseUrl =
          dotenv.env['BASE_URL'] ?? 'https://songdb-swart.vercel.app';
      final String apiKey = dotenv.env['API_KEY'] ?? '';

      final url = '$baseUrl/api/songs';
      logger.i('Fetching songs from $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (apiKey.isNotEmpty) "Authorization": "Bearer $apiKey",
        },
      );

      setState(() {
        if (response.statusCode == 200) {
          final decodedBody = jsonDecode(response.body);

          if (decodedBody is List) {
            _songs = decodedBody;
          } else if (decodedBody is Map<String, dynamic>) {
            if (decodedBody.containsKey('songs')) {
              _songs = decodedBody['songs'];
            } else if (decodedBody.containsKey('data')) {
              _songs = decodedBody['data'];
            } else if (decodedBody.containsKey('results')) {
              _songs = decodedBody['results'];
            } else {
              _songs = [decodedBody];
            }
          } else {
            _songs = [];
          }
          logger.i('Fetched ${_songs.length} songs');
        } else {
          _errorMessage = "Error: ${response.statusCode} - ${response.body}";
          logger.e('Failed to fetch songs: ${response.statusCode}');
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Exception: $e";
        _isLoading = false;
      });
      logger.e('Error fetching songs', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SONGDB'),
        actions: [
          if (!isWide)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              extended: MediaQuery.of(context).size.width >= 900,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) async {
                if (index == 1) {
                  await Navigator.pushNamed(context, '/settings');
                  setState(() {
                    _selectedIndex = 0;
                  });
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              labelType: NavigationRailLabelType.none,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('HOME'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('SETTINGS'),
                ),
              ],
            ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildSongList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) async {
                if (index == 1) {
                  await Navigator.pushNamed(context, '/settings');
                  setState(() {
                    _selectedIndex = 0;
                  });
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'SETTINGS',
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_song');
        },
        tooltip: 'ADD SONG',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSongList() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_songs.isEmpty) {
      return const Text("No songs found.");
    }

    final isTablet = MediaQuery.of(context).size.width >= 600;

    if (isTablet) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _songs.length,
        itemBuilder: (context, index) {
          final song = _songs[index];
          final title = (song['title'] ?? song['name'] ?? 'UNKNOWN TITLE')
              .toString()
              .toUpperCase();

          return Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.secondary,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                logger.d('Opening song: $title');
                final songData = Map<String, dynamic>.from(song);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongPlayerPage(song: songData),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView.builder(
      itemCount: _songs.length,
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        final song = _songs[index];
        final title = (song['title'] ?? song['name'] ?? 'UNKNOWN TITLE')
            .toString()
            .toUpperCase();

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            tileColor: Theme.of(context).colorScheme.secondary,
            leading: Icon(
              Icons.music_note,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            onTap: () {
              logger.d('Opening song: $title');
              final songData = Map<String, dynamic>.from(song);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayerPage(song: songData),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
