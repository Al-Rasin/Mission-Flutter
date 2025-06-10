import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'theme/theme_preference.dart';
import 'modules/roadmap/roadmap_view.dart';
import 'modules/settings/settings_view.dart';

class FlutterRoadmapApp extends StatefulWidget {
  @override
  _FlutterRoadmapAppState createState() => _FlutterRoadmapAppState();
}

class _FlutterRoadmapAppState extends State<FlutterRoadmapApp> {
  ThemePreference _themePreference = ThemePreference.system;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themePreference');
    setState(() {
      _themePreference = savedTheme != null
          ? ThemePreference.values.firstWhere((e) => e.toString() == savedTheme, orElse: () => ThemePreference.system)
          : ThemePreference.system;
    });
  }

  Future<void> _setThemePreference(ThemePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themePreference', preference.toString());
    setState(() {
      _themePreference = preference;
    });
  }

  ThemeMode get _themeMode {
    switch (_themePreference) {
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
        return ThemeMode.dark;
      case ThemePreference.system:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Flutter',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: RoadmapView(
        themePreference: _themePreference,
        onThemeChanged: _setThemePreference,
      ),
    );
  }
}
