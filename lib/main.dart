import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api/songdb.dart';
import 'page/add_song.dart';
import 'page/homepage.dart';
import 'page/settings.dart';
import 'theme/mhts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final api = SongDbApi();
  runApp(SongDbApp(api: api));
}

class SongDbApp extends StatefulWidget {
  const SongDbApp({super.key, required this.api});

  final SongDbApi api;

  @override
  State<SongDbApp> createState() => _SongDbAppState();
}

class _SongDbAppState extends State<SongDbApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SongDB',
      theme: Mh.theme(Brightness.light),
      darkTheme: Mh.theme(Brightness.dark),
      themeMode: _themeMode,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/add_song':
            return MaterialPageRoute(
              builder: (_) => AddSongPage(api: widget.api, onSaved: (_) {}),
            );
          case '/settings':
            return MaterialPageRoute(
              builder: (_) => SettingsPage(
                themeMode: _themeMode,
                onThemeChanged: _setThemeMode,
              ),
          );
          default:
            return MaterialPageRoute(builder: (_) => MyHomePage(api: widget.api));
        }
      },
    );
  }
}
