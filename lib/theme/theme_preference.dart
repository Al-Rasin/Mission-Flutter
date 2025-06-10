enum ThemePreference {
  light,
  dark,
  system;

  String get displayName {
    switch (this) {
      case ThemePreference.light:
        return 'Light';
      case ThemePreference.dark:
        return 'Dark';
      case ThemePreference.system:
        return 'System';
    }
  }
}
