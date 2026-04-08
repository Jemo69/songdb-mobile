import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'page/add_song.dart';
import 'page/homepage.dart';
import 'page/settings.dart';
import 'theme/mhid_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SongDB',
      theme: MHIDTheme.lightTheme,
      darkTheme: MHIDTheme.darkTheme,
      themeMode: _themeMode,
      routes: {
        '/': (context) => const MyHomePage(),
        '/add_song': (context) => const AddSongPage(),
        '/settings': (context) => SettingsPage(
          themeMode: _themeMode,
          onThemeChanged: (mode) => setState(() => _themeMode = mode),
        ),
      },
    );
  }
}
