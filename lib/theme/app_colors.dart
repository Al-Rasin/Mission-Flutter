import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Modern Blue Palette
  static const Color primary = Color(0xFF2563EB); // Blue 600
  static const Color primaryLight = Color(0xFF3B82F6); // Blue 500
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue 700
  static const Color primaryAccent = Color(0xFF60A5FA); // Blue 400

  // Background Colors - Subtle and Professional
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900
  static const Color lightCardBackground = Colors.white;
  static const Color darkCardBackground = Color(0xFF1E293B); // Slate 800

  // App Bar Colors - Clean and Modern
  static const Color lightAppBar = Color(0xFF2563EB); // Blue 600
  static const Color darkAppBar = Color(0xFF1E293B); // Slate 800

  // Text Colors - High Contrast and Readable
  static const Color lightTextPrimary = Color(0xFF1E293B); // Slate 800
  static const Color lightTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color lightTextHint = Color(0xFF94A3B8); // Slate 400
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // Slate 100
  static const Color darkTextSecondary = Color(0xFFCBD5E1); // Slate 300
  static const Color darkTextHint = Color(0xFF94A3B8); // Slate 400

  // Priority Colors - Semantic and Accessible
  static const Color highPriority = Color(0xFFDC2626); // Red 600
  static const Color highPriorityLight = Color(0xFFFEF2F2); // Red 50
  static const Color mediumPriority = Color(0xFFEA580C); // Orange 600
  static const Color mediumPriorityLight = Color(0xFFFFF7ED); // Orange 50
  static const Color lowPriority = Color(0xFF16A34A); // Green 600
  static const Color lowPriorityLight = Color(0xFFF0FDF4); // Green 50

  // Status Colors - Professional and Clear
  static const Color success = Color(0xFF16A34A); // Green 600
  static const Color successLight = Color(0xFFF0FDF4); // Green 50
  static const Color warning = Color(0xFFEA580C); // Orange 600
  static const Color warningLight = Color(0xFFFFF7ED); // Orange 50
  static const Color error = Color(0xFFDC2626); // Red 600
  static const Color errorLight = Color(0xFFFEF2F2); // Red 50
  static const Color info = Color(0xFF2563EB); // Blue 600
  static const Color infoLight = Color(0xFFEFF6FF); // Blue 50

  // Challenge Colors - Vibrant but Professional
  static const Color challenge = Color(0xFF7C3AED); // Violet 600
  static const Color challengeLight = Color(0xFFF5F3FF); // Violet 50

  // Divider Colors - Subtle and Clean
  static const Color lightDivider = Color(0xFFE2E8F0); // Slate 200
  static const Color darkDivider = Color(0xFF334155); // Slate 700

  // Input Colors - Clean and Accessible
  static const Color lightInputBackground = Colors.white;
  static const Color darkInputBackground = Color(0xFF334155); // Slate 700
  static const Color lightInputBorder = Color(0xFFCBD5E1); // Slate 300
  static const Color darkInputBorder = Color(0xFF475569); // Slate 600

  // Timer Colors - Clear and Intuitive
  static const Color timerActive = Color(0xFF2563EB); // Blue 600
  static const Color timerPaused = Color(0xFFEA580C); // Orange 600
  static const Color timerStopped = Color(0xFFDC2626); // Red 600

  // Note Colors - Pleasant and Distinctive
  static const Color noteYellow = Color(0xFFEAB308); // Yellow 500
  static const Color noteGreen = Color(0xFF22C55E); // Green 500
  static const Color noteCyan = Color(0xFF06B6D4); // Cyan 500
  static const Color notePink = Color(0xFFEC4899); // Pink 500
  static const Color noteAmber = Color(0xFFF59E0B); // Amber 500

  // Gradient Colors for Enhanced Visual Appeal
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF1E293B), Color(0xFF334155)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
