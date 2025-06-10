import '../../theme/theme_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController {
  Future<void> setThemePreference(ThemePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themePreference', preference.toString());
  }

  Future<void> resetApp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
