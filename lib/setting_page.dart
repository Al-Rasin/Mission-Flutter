import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

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
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.refresh, color: Colors.red),
            title: Text('Reset Full App'),
            subtitle: Text('Erase all progress, notes, and settings.'),
            onTap: () => _resetApp(context),
          ),
        ],
      ),
    );
  }
}
