import 'package:flutter/material.dart';
import '../../theme/theme_preference.dart';
import '../../theme/app_colors.dart';
import '../../utils/confirmation_dialog.dart';
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
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Reset App',
      message:
          'Are you sure you want to reset all app data? This will clear:\n\n• All progress tracking\n• Timer logs\n• Notes\n• Settings\n\nThis action cannot be undone.',
      confirmText: 'Reset',
      cancelText: 'Cancel',
      confirmColor: AppColors.error,
    );

    if (confirmed == true) {
      await _controller.resetApp();
      if (mounted) Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = AppColors.getBackgroundColor(isDark);
    final cardColor = AppColors.getCardColor(isDark);
    final textColor = AppColors.getTextPrimaryColor(isDark);
    final subtitleColor = AppColors.getTextSecondaryColor(isDark);
    final appBarColor = AppColors.getAppBarColor(isDark);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: appBarColor,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: cardColor,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.palette, color: AppColors.primaryAccent),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Theme Mode',
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                        ),
                        DropdownButton<ThemePreference>(
                          value: widget.themePreference,
                          underline: Container(),
                          items: ThemePreference.values.map((preference) {
                            return DropdownMenuItem<ThemePreference>(
                              value: preference,
                              child: Text(
                                preference.displayName,
                                style: TextStyle(color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (ThemePreference? newValue) {
                            if (newValue != null) {
                              widget.onThemeChanged(newValue);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: cardColor,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.refresh, color: AppColors.warning),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reset App Data',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Clear all progress, timers, and notes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _resetAppData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: cardColor,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.info, color: AppColors.info),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mission Flutter',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Flutter Learning Roadmap Tracker',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetAppData() async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Reset App Data',
      message:
          'Are you sure you want to reset all app data? This will clear:\n\n• All progress tracking\n• Timer logs\n• Notes\n• Settings\n\nThis action cannot be undone.',
      confirmText: 'Reset',
      cancelText: 'Cancel',
      confirmColor: AppColors.error,
    );

    if (confirmed == true) {
      final success = await _controller.resetApp();
      if (mounted) {
        Navigator.of(context).pop(success);
      }
    }
  }
}
