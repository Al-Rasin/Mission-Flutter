import 'package:flutter/material.dart';

class ColorUtils {
  static Color getPriorityColor(String priority, {bool background = false}) {
    switch (priority.toLowerCase()) {
      case 'high':
        return background ? Colors.red[50]! : Colors.red[700]!;
      case 'medium':
        return background ? Colors.orange[50]! : Colors.orange[700]!;
      case 'low':
        return background ? Colors.green[50]! : Colors.green[700]!;
      default:
        return background ? Colors.grey[100]! : Colors.grey[700]!;
    }
  }
}
