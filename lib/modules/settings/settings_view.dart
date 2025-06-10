import 'package:flutter/material.dart';
import '../../theme/theme_preference.dart';
import 'settings_controller.dart';

class SettingsView extends StatefulWidget {
  final ThemePreference themePreference;
  final Function(ThemePreference) onThemeChanged;

  const SettingsView({
    Key? key,
    required this.themePreference,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late ThemePreference _themePreference;
  final SettingsController _controller = SettingsController();

  @override
  void initState() {
    super.initState();
    _themePreference = widget.themePreference;
  }

  void _onThemeChanged(ThemePreference? preference) async {
    if (preference == null) return;
    await _controller.setThemePreference(preference);
    setState(() {
      _themePreference = preference;
    });
    widget.onThemeChanged(preference);
  }

  void _onResetApp() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset App'),
        content: Text('Are you sure you want to reset all app data? This cannot be undone.'),
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
      await _controller.resetApp();
      if (mounted) Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Theme'),
            subtitle: Text('Choose app theme'),
          ),
          RadioListTile<ThemePreference>(
            title: Text('System'),
            value: ThemePreference.system,
            groupValue: _themePreference,
            onChanged: _onThemeChanged,
          ),
          RadioListTile<ThemePreference>(
            title: Text('Light'),
            value: ThemePreference.light,
            groupValue: _themePreference,
            onChanged: _onThemeChanged,
          ),
          RadioListTile<ThemePreference>(
            title: Text('Dark'),
            value: ThemePreference.dark,
            groupValue: _themePreference,
            onChanged: _onThemeChanged,
          ),
          Divider(),
          ListTile(
            title: Text('Reset App'),
            subtitle: Text('Clear all progress, notes, and settings'),
            trailing: Icon(Icons.restore, color: Colors.red),
            onTap: _onResetApp,
          ),
        ],
      ),
    );
  }
}
