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

class SongDbApp extends StatelessWidget {
  const SongDbApp({super.key, required this.api});

  final SongDbApi api;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SongDB',
      theme: Mh.theme(Brightness.light),
      darkTheme: Mh.theme(Brightness.dark),
      themeMode: ThemeMode.system,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => MyHomePage(api: api));
          case '/add_song':
            return MaterialPageRoute(
              builder: (_) => AddSongPage(
                api: api,
                onSaved: (_) {},
              ),
            );
          case '/settings':
            return MaterialPageRoute(builder: (_) => const _SettingsRoute());
          default:
            return MaterialPageRoute(
              builder: (_) => MyHomePage(api: api),
            );
        }
      },
    );
  }
}

class _SettingsRoute extends StatefulWidget {
  const _SettingsRoute();

  @override
  State<_SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<_SettingsRoute> {
  ThemeMode _mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      themeMode: _mode,
      onThemeChanged: (mode) => setState(() => _mode = mode),
    );
  }
}
