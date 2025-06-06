import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_preference.dart';

class SettingPage extends StatelessWidget {
  final ThemePreference themePreference;
  final Function(ThemePreference) onThemeChanged;

  const SettingPage({
    Key? key,
    required this.themePreference,
    required this.onThemeChanged,
  }) : super(key: key);

  Future<void> _resetApp(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Full App'),
        content: Text('Are you sure you want to reset the entire app? This will erase all your progress and notes.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('App has been reset.')),
      );
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.blue[800],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.refresh, color: Colors.red),
            title: Text('Reset Full App'),
            subtitle: Text('Erase all progress, notes, and settings.'),
            onTap: () => _resetApp(context),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87,
                      ),
                ),
                RadioListTile<ThemePreference>(
                  title: Row(
                    children: [
                      Icon(Icons.light_mode, color: Colors.amber),
                      SizedBox(width: 8),
                      Text('Light Theme'),
                    ],
                  ),
                  value: ThemePreference.light,
                  groupValue: themePreference,
                  onChanged: (ThemePreference? value) {
                    if (value != null) onThemeChanged(value);
                  },
                ),
                RadioListTile<ThemePreference>(
                  title: Row(
                    children: [
                      Icon(Icons.dark_mode, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Dark Theme'),
                    ],
                  ),
                  value: ThemePreference.dark,
                  groupValue: themePreference,
                  onChanged: (ThemePreference? value) {
                    if (value != null) onThemeChanged(value);
                  },
                ),
                RadioListTile<ThemePreference>(
                  title: Row(
                    children: [
                      Icon(Icons.brightness_auto, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('System Theme'),
                    ],
                  ),
                  value: ThemePreference.system,
                  groupValue: themePreference,
                  onChanged: (ThemePreference? value) {
                    if (value != null) onThemeChanged(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
