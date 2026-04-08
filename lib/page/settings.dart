import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'THEME SELECTION',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          _buildThemeOption(
            context,
            'SYSTEM DEFAULT',
            Icons.brightness_auto,
            ThemeMode.system,
          ),
          const SizedBox(height: 12),
          _buildThemeOption(
            context,
            'LIGHT MODE',
            Icons.light_mode,
            ThemeMode.light,
          ),
          const SizedBox(height: 12),
          _buildThemeOption(
            context,
            'DARK MODE',
            Icons.dark_mode,
            ThemeMode.dark,
          ),
          const SizedBox(height: 32),
          const Divider(thickness: 1),
          const SizedBox(height: 16),
          Text(
            'SYSTEM VERSION: 1.0.0 (MHID)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode mode,
  ) {
    final isSelected = themeMode == mode;
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      leading: Icon(
        icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.64),
      ),
      tileColor: isSelected
          ? Theme.of(context).colorScheme.secondary
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            )
          : null,
      onTap: () => onThemeChanged(mode),
    );
  }
}
