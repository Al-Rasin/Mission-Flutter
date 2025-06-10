import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Colors.blue;
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryAccent = Color(0xFF2196F3);

  // Background Colors
  static const Color lightBackground = Color(0xFFF3F8FF); // Light blue tint
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color lightCardBackground = Colors.white;
  static const Color darkCardBackground = Color(0xFF2D2D2D);

  // App Bar Colors
  static const Color lightAppBar = Color(0xFF1976D2); // Blue 700
  static const Color darkAppBar = Color(0xFF1F1F1F);

  // Text Colors
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextHint = Color(0xFFBDBDBD);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFBDBDBD);
  static const Color darkTextHint = Color(0xFF757575);

  // Priority Colors
  static const Color highPriority = Color(0xFFD32F2F); // Red 700
  static const Color highPriorityLight = Color(0xFFFFEBEE); // Red 50
  static const Color mediumPriority = Color(0xFFF57C00); // Orange 700
  static const Color mediumPriorityLight = Color(0xFFFFF3E0); // Orange 50
  static const Color lowPriority = Color(0xFF388E3C); // Green 700
  static const Color lowPriorityLight = Color(0xFFE8F5E8); // Green 50

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green 500
  static const Color successLight = Color(0xFFE8F5E8); // Green 50
  static const Color warning = Color(0xFFFF9800); // Orange 500
  static const Color warningLight = Color(0xFFFFF3E0); // Orange 50
  static const Color error = Color(0xFFF44336); // Red 500
  static const Color errorLight = Color(0xFFFFEBEE); // Red 50
  static const Color info = Color(0xFF2196F3); // Blue 500
  static const Color infoLight = Color(0xFFE3F2FD); // Blue 50

  // Challenge Colors
  static const Color challenge = Color(0xFFFF5722); // Deep Orange 500
  static const Color challengeLight = Color(0xFFFBE9E7); // Deep Orange 50

  // Divider Colors
  static const Color lightDivider = Color(0xFFE3F2FD); // Blue 50
  static const Color darkDivider = Color(0xFF424242);

  // Input Colors
  static const Color lightInputBackground = Colors.white;
  static const Color darkInputBackground = Color(0xFF2D2D2D);
  static const Color lightInputBorder = Color(0xFFE0E0E0);
  static const Color darkInputBorder = Color(0xFF424242);

  // Timer Colors
  static const Color timerActive = Color(0xFF1976D2); // Blue 700
  static const Color timerPaused = Color(0xFFFF9800); // Orange 500
  static const Color timerStopped = Color(0xFFF44336); // Red 500

  // Note Colors
  static const Color noteYellow = Color(0xFFFFEB3B); // Yellow 500
  static const Color noteGreen = Color(0xFF8BC34A); // Light Green 500
  static const Color noteCyan = Color(0xFF00BCD4); // Cyan 500
  static const Color notePink = Color(0xFFE91E63); // Pink 500
  static const Color noteAmber = Color(0xFFFFC107); // Amber 500

  // Get priority color based on priority string
  static Color getPriorityColor(String priority, {bool background = false}) {
    switch (priority.toLowerCase()) {
      case 'high':
        return background ? highPriorityLight : highPriority;
      case 'medium':
        return background ? mediumPriorityLight : mediumPriority;
      case 'low':
        return background ? lowPriorityLight : lowPriority;
      default:
        return background ? lightDivider : lightTextSecondary;
    }
  }

  // Get theme-aware colors
  static Color getBackgroundColor(bool isDark) {
    return isDark ? darkBackground : lightBackground;
  }

  static Color getCardColor(bool isDark) {
    return isDark ? darkCardBackground : lightCardBackground;
  }

  static Color getAppBarColor(bool isDark) {
    return isDark ? darkAppBar : lightAppBar;
  }

  static Color getTextPrimaryColor(bool isDark) {
    return isDark ? darkTextPrimary : lightTextPrimary;
  }

  static Color getTextSecondaryColor(bool isDark) {
    return isDark ? darkTextSecondary : lightTextSecondary;
  }

  static Color getTextHintColor(bool isDark) {
    return isDark ? darkTextHint : lightTextHint;
  }

  static Color getDividerColor(bool isDark) {
    return isDark ? darkDivider : lightDivider;
  }

  static Color getInputBackgroundColor(bool isDark) {
    return isDark ? darkInputBackground : lightInputBackground;
  }

  static Color getInputBorderColor(bool isDark) {
    return isDark ? darkInputBorder : lightInputBorder;
  }
}
