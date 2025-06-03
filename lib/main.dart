import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'setting_page.dart';

void main() => runApp(FlutterRoadmapApp());

class FlutterRoadmapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Guide',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RoadmapHomePage(),
    );
  }
}

class RoadmapHomePage extends StatefulWidget {
  @override
  _RoadmapHomePageState createState() => _RoadmapHomePageState();
}

class _RoadmapHomePageState extends State<RoadmapHomePage> {
  List<RoadmapItem> allItems = [
    RoadmapItem(day: 'Day 1', topic: 'Setup & Environment', subtopic: 'Install SDK', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 2', topic: 'Setup & Environment', subtopic: 'Set PATH', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 3', topic: 'Setup & Environment', subtopic: 'Run flutter doctor', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 4', topic: 'Setup & Environment', subtopic: 'Fix issues', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 5', topic: 'Setup & Environment', subtopic: 'Install VS Code', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 6', topic: 'Setup & Environment', subtopic: 'Add Flutter extension', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 7', topic: 'Setup & Environment', subtopic: 'Set up Android Studio', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 8', topic: 'Setup & Environment', subtopic: 'Configure emulator', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 9', topic: 'Setup & Environment', subtopic: "Run 'flutter create'", icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 10', topic: 'Setup & Environment', subtopic: 'Explore commands', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 11', topic: 'Setup & Environment', subtopic: 'Hot reload vs restart', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 12', topic: 'Setup & Environment', subtopic: 'Write Hello World', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 13', topic: 'Setup & Environment', subtopic: 'Try variables & print()', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 14', topic: 'Setup & Environment', subtopic: 'Use basic widgets online', icon: '🛠️', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 15', topic: 'Dart Basics', subtopic: 'Declare int, double, String', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 16', topic: 'Dart Basics', subtopic: 'Use var, final, const', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 17', topic: 'Dart Basics', subtopic: 'Naming conventions', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 18', topic: 'Dart Basics', subtopic: 'Mini challenge: Variable puzzle', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 19', topic: 'Dart Basics', subtopic: 'Numbers', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 20', topic: 'Dart Basics', subtopic: 'Strings', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 21', topic: 'Dart Basics', subtopic: 'Booleans', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 22', topic: 'Dart Basics', subtopic: 'Lists', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 23', topic: 'Dart Basics', subtopic: 'Maps', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 24', topic: 'Dart Basics', subtopic: 'Challenge: Type guessing game', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 25', topic: 'Dart Basics', subtopic: 'Arithmetic', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 26', topic: 'Dart Basics', subtopic: 'Logical', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 27', topic: 'Dart Basics', subtopic: 'Assignment', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 28', topic: 'Dart Basics', subtopic: 'Challenge: Calculator', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 29', topic: 'Dart Basics', subtopic: 'Syntax', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 30', topic: 'Dart Basics', subtopic: 'Optional params', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 31', topic: 'Dart Basics', subtopic: 'Arrow syntax', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 32', topic: 'Dart Basics', subtopic: 'Challenge: Palindrome checker', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 33', topic: 'Dart Basics', subtopic: 'if/else', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 34', topic: 'Dart Basics', subtopic: 'for/while', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 35', topic: 'Dart Basics', subtopic: 'switch', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 36', topic: 'Dart Basics', subtopic: 'Challenge: Prime number detector', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 37', topic: 'Dart Basics', subtopic: 'List basics', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 38', topic: 'Dart Basics', subtopic: 'Map basics', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 39', topic: 'Dart Basics', subtopic: 'List methods', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 40', topic: 'Dart Basics', subtopic: 'Challenge: Frequency counter', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 41', topic: 'Dart Basics', subtopic: 'Anonymous functions', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 42', topic: 'Dart Basics', subtopic: 'Use in map/filter', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 43', topic: 'Dart Basics', subtopic: 'Challenge: Use lambda in loop', icon: '🧠', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 44', topic: 'OOP & Design Principles', subtopic: 'OOP Concepts', icon: '🧱', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 45', topic: 'OOP & Design Principles', subtopic: 'SOLID Principles', icon: '🧱', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 46', topic: 'OOP & Design Principles', subtopic: 'Design Patterns', icon: '🧱', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 47', topic: 'OOP & Design Principles', subtopic: 'Dependency Injection', icon: '🧱', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 48', topic: 'Flutter Fundamentals', subtopic: 'Create widget', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 49', topic: 'Flutter Fundamentals', subtopic: 'Build method', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 50', topic: 'Flutter Fundamentals', subtopic: 'SetState usage', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 51', topic: 'Flutter Fundamentals', subtopic: 'Mini UI layout', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 52', topic: 'Flutter Fundamentals', subtopic: 'Explore both', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 53', topic: 'Flutter Fundamentals', subtopic: 'Theming', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 54', topic: 'Flutter Fundamentals', subtopic: 'Basic nav', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 55', topic: 'Flutter Fundamentals', subtopic: 'Challenge: Mixed UI', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 56', topic: 'Flutter Fundamentals', subtopic: 'Add images/fonts', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 57', topic: 'Flutter Fundamentals', subtopic: 'Use in app', icon: '🎯', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 58',
        topic: 'Flutter Fundamentals',
        subtopic: 'Challenge: Build intro page with asset banner',
        icon: '🎯',
        priority: 'High',
        estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 59', topic: 'State Management', subtopic: 'Install package', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 60', topic: 'State Management', subtopic: 'ChangeNotifier', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 61', topic: 'State Management', subtopic: 'Consumer', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 62',
        topic: 'State Management',
        subtopic: 'Challenge: Counter with Provider',
        icon: '🔄',
        priority: 'High',
        estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 63', topic: 'State Management', subtopic: 'Streams', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 64', topic: 'State Management', subtopic: 'Sink/Stream', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 65', topic: 'State Management', subtopic: 'Challenge: Stopwatch app', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 66', topic: 'State Management', subtopic: 'Obx', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 67', topic: 'State Management', subtopic: 'GetBuilder', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 68', topic: 'State Management', subtopic: 'Challenge: Quiz app', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 69', topic: 'State Management', subtopic: 'Actions', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 70', topic: 'State Management', subtopic: 'Reducers', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 71', topic: 'State Management', subtopic: 'Store', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 72', topic: 'State Management', subtopic: 'Challenge: Todo with Redux', icon: '🔄', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 73', topic: 'API Integration', subtopic: 'HTTP get', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 74', topic: 'API Integration', subtopic: 'Parse JSON', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 75', topic: 'API Integration', subtopic: 'Error handling', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 76', topic: 'API Integration', subtopic: 'Challenge: Fetch quotes', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 77', topic: 'API Integration', subtopic: 'Intro to queries', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 78', topic: 'API Integration', subtopic: 'Using GraphQL package', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 79', topic: 'API Integration', subtopic: 'Challenge: List books', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 80', topic: 'API Integration', subtopic: 'Socket basics', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 81', topic: 'API Integration', subtopic: 'Connect to endpoint', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 82', topic: 'API Integration', subtopic: 'Challenge: Chat interface', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 83', topic: 'API Integration', subtopic: 'dart:convert', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 84', topic: 'API Integration', subtopic: 'Model classes', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 85', topic: 'API Integration', subtopic: 'Challenge: Convert nested JSON', icon: '🌐', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 86', topic: 'Storage', subtopic: 'Store key-values', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 87', topic: 'Storage', subtopic: 'Challenge: Theme toggler', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 88', topic: 'Storage', subtopic: 'DB init', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 89', topic: 'Storage', subtopic: 'CRUD ops', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 90', topic: 'Storage', subtopic: 'Challenge: Notes app', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 91', topic: 'Storage', subtopic: 'Events', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 92', topic: 'Storage', subtopic: 'Challenge: Track page views', icon: '💾', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 93', topic: 'Authentication', subtopic: 'Firebase setup', icon: '🔐', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 94', topic: 'Authentication', subtopic: 'Validation', icon: '🔐', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 95', topic: 'Authentication', subtopic: 'Challenge: Auth UI', icon: '🔐', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 96', topic: 'Authentication', subtopic: 'Google sign-in', icon: '🔐', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 97', topic: 'Authentication', subtopic: 'Challenge: Login + profile pic', icon: '🔐', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 98', topic: 'Animations', subtopic: 'AnimatedContainer', icon: '🎨', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 99', topic: 'Animations', subtopic: 'AnimatedOpacity', icon: '🎨', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 100', topic: 'Animations', subtopic: 'Challenge: Fade transition', icon: '🎨', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 101', topic: 'Animations', subtopic: 'Hero animations', icon: '🎨', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 102', topic: 'Animations', subtopic: 'Curves', icon: '🎨', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 103', topic: 'Animations', subtopic: 'Challenge: Photo detail viewer', icon: '🎨', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 104', topic: 'Testing', subtopic: 'Simple test', icon: '🧪', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 105', topic: 'Testing', subtopic: 'Challenge: Test math utils', icon: '🧪', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 106', topic: 'Testing', subtopic: 'PumpWidget', icon: '🧪', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 107', topic: 'Testing', subtopic: 'Challenge: Button state test', icon: '🧪', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 108', topic: 'Testing', subtopic: 'End-to-end UI', icon: '🧪', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 109', topic: 'Testing', subtopic: 'Challenge: Full login flow', icon: '🧪', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 110', topic: 'Advanced Dart', subtopic: 'Delays', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 111', topic: 'Advanced Dart', subtopic: 'Futures', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 112', topic: 'Advanced Dart', subtopic: 'Challenge: Wait simulation', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 113', topic: 'Advanced Dart', subtopic: 'StreamBuilder', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 114', topic: 'Advanced Dart', subtopic: 'Challenge: Timer app', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 115', topic: 'Advanced Dart', subtopic: 'FutureBuilder', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 116', topic: 'Advanced Dart', subtopic: 'Challenge: Load data', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 117', topic: 'Advanced Dart', subtopic: 'Compute-heavy task', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 118', topic: 'Advanced Dart', subtopic: 'Challenge: Fibonacci isolate', icon: '🌀', priority: 'Medium', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 119', topic: 'DevTools', subtopic: 'Explore widget tree', icon: '⚙️', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 120', topic: 'DevTools', subtopic: 'Hot reload', icon: '⚙️', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 121', topic: 'DevTools', subtopic: 'Challenge: UI debug', icon: '⚙️', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 122', topic: 'DevTools', subtopic: 'Check usage', icon: '⚙️', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 123', topic: 'DevTools', subtopic: 'Challenge: Leak detection', icon: '⚙️', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 124', topic: 'Flutter Internals', subtopic: 'Tree overview', icon: '🧬', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 125', topic: 'Flutter Internals', subtopic: 'CustomRenderBox', icon: '🧬', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 126', topic: 'Flutter Internals', subtopic: 'Widget, Element, Render', icon: '🧬', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 127', topic: 'Flutter Internals', subtopic: 'Challenge: Trace rebuilds', icon: '🧬', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 128', topic: 'Flutter Internals', subtopic: 'const widgets', icon: '🧬', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 129', topic: 'Flutter Internals', subtopic: 'Challenge: Reuse widgets', icon: '🧬', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 130', topic: 'CI/CD & Deployment', subtopic: 'CI for test', icon: '🚀', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 131',
        topic: 'CI/CD & Deployment',
        subtopic: 'Challenge: Deploy to Firebase',
        icon: '🚀',
        priority: 'High',
        estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 132', topic: 'CI/CD & Deployment', subtopic: 'Build pipeline', icon: '🚀', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 133', topic: 'CI/CD & Deployment', subtopic: 'Challenge: Auto deploy', icon: '🚀', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 134', topic: 'CI/CD & Deployment', subtopic: 'Bundle signing', icon: '🚀', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(
        day: 'Day 135', topic: 'CI/CD & Deployment', subtopic: 'Challenge: Upload test app', icon: '🚀', priority: 'High', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 136', topic: 'Analytics', subtopic: 'Events', icon: '📈', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 137', topic: 'Analytics', subtopic: 'Challenge: Track page views', icon: '📈', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 138', topic: 'Analytics', subtopic: 'Setup', icon: '📈', priority: 'Low', estimatedTime: '2–3 hrs'),
    RoadmapItem(day: 'Day 139', topic: 'Analytics', subtopic: 'Challenge: Track user flow', icon: '📈', priority: 'Low', estimatedTime: '2–3 hrs'),
  ];

  List<String> completed = [];
  String selectedTopic = 'All';
  String selectedPriority = 'All';
  Map<String, List<Map<String, dynamic>>> timingLogs = {};
  Map<String, Duration> totalTimes = {};
  Map<String, bool> isTiming = {};
  Map<String, DateTime?> currentStart = {};
  Timer? timer;
  String? activeKey;
  Duration currentSession = Duration.zero;
  Map<String, Map<String, dynamic>> notes = {};
  Map<String, TextEditingController> noteControllers = {};
  Map<String, TextStyle> noteStyles = {};
  Map<String, Color?> noteHighlights = {};
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String? expandedKey;
  final DateTime startingDate = DateTime(2025, 6, 3);
  DateTime? actualStartDate;

  Future<void> loadActualStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final millis = prefs.getInt('actualStartDate');
    if (millis != null) {
      setState(() {
        actualStartDate = DateTime.fromMillisecondsSinceEpoch(millis);
      });
    }
  }

  Future<void> saveActualStartDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('actualStartDate', date.millisecondsSinceEpoch);
    setState(() {
      actualStartDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProgress();
    loadTimingSafe();
    loadNotesSafe();
    loadActualStartDate();
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completed = prefs.getStringList('completedItems') ?? [];
    });
  }

  Future<void> toggleComplete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (completed.contains(key)) {
        completed.remove(key);
      } else {
        completed.add(key);
        if (key == 'Day 1-Install SDK' && actualStartDate == null) {
          saveActualStartDate(DateTime.now());
        }
      }
      prefs.setStringList('completedItems', completed);
    });
  }

  Future<void> loadTiming() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final logsString = prefs.getString('timingLogs');
      if (logsString != null) {
        final logsMap = jsonDecode(logsString) as Map<String, dynamic>;
        timingLogs = logsMap.map((k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)));
      }
      final totalsString = prefs.getString('totalTimes');
      if (totalsString != null) {
        final totalsMap = jsonDecode(totalsString) as Map<String, dynamic>;
        totalTimes = totalsMap.map((k, v) => MapEntry(k, Duration(seconds: v as int)));
      }
    });
  }

  Future<void> saveTiming() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('timingLogs', jsonEncode(timingLogs));
    prefs.setString('totalTimes', jsonEncode(totalTimes.map((k, v) => MapEntry(k, v.inSeconds))));
  }

  void startTimer(String key) {
    if (isTiming[key] == true) return;
    setState(() {
      isTiming[key] = true;
      currentStart[key] = DateTime.now();
      activeKey = key;
      if (key == 'Day 1-Install SDK' && actualStartDate == null) {
        saveActualStartDate(DateTime.now());
      }
    });
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        currentSession += Duration(seconds: 1);
      });
    });
  }

  void pauseTimer(String key) {
    if (isTiming[key] != true) return;
    timer?.cancel();
    final start = currentStart[key];
    if (start != null) {
      final end = DateTime.now();
      final duration = end.difference(start);
      setState(() {
        isTiming[key] = false;
        totalTimes[key] = (totalTimes[key] ?? Duration.zero) + duration;
        timingLogs[key] = (timingLogs[key] ?? [])
          ..add({
            'start': start.toIso8601String(),
            'end': end.toIso8601String(),
            'duration': duration.inSeconds,
          });
        currentStart[key] = null;
        currentSession = Duration.zero;
      });
      saveTiming();
    }
  }

  void stopTimer(String key) {
    pauseTimer(key);
    setState(() {
      currentSession = Duration.zero;
      activeKey = null;
    });
  }

  void resetTimer(String key) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Timer'),
        content: Text('Are you sure you want to reset the timer and all logs for this topic?'),
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
      setState(() {
        totalTimes[key] = Duration.zero;
        timingLogs[key] = [];
        isTiming[key] = false;
        currentStart[key] = null;
        currentSession = Duration.zero;
      });
      saveTiming();
    }
  }

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }

  List<RoadmapItem> get filteredItems => allItems.where((item) {
        final key = '${item.day}-${item.subtopic}';
        final noteText = notes[key]?['text']?.toString().toLowerCase() ?? '';
        final query = searchQuery.toLowerCase();
        final matchesSearch = query.isEmpty ||
            item.day.toLowerCase().contains(query) ||
            item.topic.toLowerCase().contains(query) ||
            item.subtopic.toLowerCase().contains(query) ||
            item.priority.toLowerCase().contains(query) ||
            noteText.contains(query);
        return (selectedTopic == 'All' || item.topic == selectedTopic) &&
            (selectedPriority == 'All' || item.priority == selectedPriority) &&
            matchesSearch;
      }).toList();

  double get progress => completed.length / allItems.length.clamp(1, allItems.length);

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final notesString = prefs.getString('notes');
      if (notesString != null) {
        final notesMap = jsonDecode(notesString) as Map<String, dynamic>;
        notes = notesMap.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v)));
      }
    });
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('notes', jsonEncode(notes));
  }

  void updateNote(String key, String text, TextStyle style, Color? highlight, bool important) {
    setState(() {
      notes[key] = {
        'text': text,
        'fontSize': style.fontSize ?? 16.0,
        'color': style.color?.value ?? Colors.black.value,
        'bold': style.fontWeight == FontWeight.bold,
        'italic': style.fontStyle == FontStyle.italic,
        'highlight': highlight?.value,
        'important': important,
      };
    });
    saveNotes();
  }

  TextStyle getNoteStyle(String key) {
    final note = notes[key];
    return TextStyle(
      fontSize: (note?['fontSize'] ?? 16.0) as double,
      color: Color(note?['color'] ?? Colors.black.value),
      fontWeight: note?['bold'] == true ? FontWeight.bold : FontWeight.normal,
      fontStyle: note?['italic'] == true ? FontStyle.italic : FontStyle.normal,
      backgroundColor: note?['highlight'] != null ? Color(note!['highlight']) : null,
    );
  }

  bool isNoteImportant(String key) {
    return notes[key]?['important'] == true;
  }

  void showNoteEditor(BuildContext context, String key) {
    final note = notes[key];
    final controller = noteControllers[key] ??= TextEditingController(text: note?['text'] ?? '');
    double fontSize = (note?['fontSize'] ?? 16.0) as double;
    Color color = Color(note?['color'] ?? Colors.black.value);
    bool bold = note?['bold'] == true;
    bool italic = note?['italic'] == true;
    Color? highlight = note?['highlight'] != null ? Color(note!['highlight']) : null;
    bool important = note?['important'] == true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.format_bold, color: bold ? Colors.blue : Colors.grey),
                          onPressed: () => setModalState(() => bold = !bold),
                          tooltip: 'Bold',
                        ),
                        IconButton(
                          icon: Icon(Icons.format_italic, color: italic ? Colors.blue : Colors.grey),
                          onPressed: () => setModalState(() => italic = !italic),
                          tooltip: 'Italic',
                        ),
                        IconButton(
                          icon: Icon(Icons.format_color_text, color: color),
                          onPressed: () async {
                            final picked = await showDialog<Color?>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Pick Text Color'),
                                content: SingleChildScrollView(
                                  child: Wrap(
                                    spacing: 8,
                                    children: [Colors.black, Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.brown]
                                        .map((c) => GestureDetector(
                                              onTap: () => Navigator.of(context).pop(c),
                                              child: CircleAvatar(backgroundColor: c, radius: 16),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                            if (picked != null) setModalState(() => color = picked);
                          },
                          tooltip: 'Text Color',
                        ),
                        IconButton(
                          icon: Icon(Icons.format_color_fill, color: highlight ?? Colors.grey),
                          onPressed: () async {
                            final picked = await showDialog<Color?>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Pick Highlight Color'),
                                content: SingleChildScrollView(
                                  child: Wrap(
                                    spacing: 8,
                                    children: [null, Colors.yellow, Colors.lightGreen, Colors.cyan, Colors.pink[100], Colors.amber[200]]
                                        .map((c) => GestureDetector(
                                              onTap: () => Navigator.of(context).pop(c),
                                              child: CircleAvatar(
                                                  backgroundColor: c ?? Colors.white,
                                                  radius: 16,
                                                  child: c == null ? Icon(Icons.clear, color: Colors.black) : null),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                            setModalState(() => highlight = picked);
                          },
                          tooltip: 'Highlight',
                        ),
                        IconButton(
                          icon: Icon(Icons.star, color: important ? Colors.orange : Colors.grey),
                          onPressed: () => setModalState(() => important = !important),
                          tooltip: 'Mark as Important',
                        ),
                        SizedBox(width: 8),
                        DropdownButton<double>(
                          value: fontSize,
                          items: [14.0, 16.0, 20.0, 24.0]
                              .map((size) => DropdownMenuItem(
                                    value: size,
                                    child: Text('${size.toInt()}', style: TextStyle(fontSize: size)),
                                  ))
                              .toList(),
                          onChanged: (v) => setModalState(() => fontSize = v ?? 16.0),
                          underline: SizedBox(),
                          style: TextStyle(fontSize: 16),
                          icon: Icon(Icons.text_fields),
                        ),
                      ],
                    ),
                    TextField(
                      controller: controller,
                      maxLines: null,
                      minLines: 3,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: color,
                        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                        backgroundColor: highlight,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your note...',
                        border: OutlineInputBorder(),
                        fillColor: highlight,
                        filled: highlight != null,
                      ),
                      onChanged: (text) {
                        updateNote(
                          key,
                          text,
                          TextStyle(
                            fontSize: fontSize,
                            color: color,
                            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                            backgroundColor: highlight,
                          ),
                          highlight,
                          important,
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          updateNote(
                            key,
                            controller.text,
                            TextStyle(
                              fontSize: fontSize,
                              color: color,
                              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                              fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                              backgroundColor: highlight,
                            ),
                            highlight,
                            important,
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700]),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> loadTimingSafe() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await loadTiming();
    } catch (e) {
      // If error, clear old/corrupt data and reload
      await prefs.remove('timingLogs');
      await prefs.remove('totalTimes');
      setState(() {
        timingLogs = {};
        totalTimes = {};
      });
    }
  }

  Future<void> loadNotesSafe() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await loadNotes();
    } catch (e) {
      // If error, clear old/corrupt data and reload
      await prefs.remove('notes');
      setState(() {
        notes = {};
      });
    }
  }

  // Add this function to get color based on priority
  Color getPriorityColor(String priority, {bool background = false}) {
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

  String _getDynamicDate(String day) {
    if (actualStartDate == null) {
      return 'Not started';
    }
    final match = RegExp(r'Day (\d+)').firstMatch(day);
    if (match != null) {
      final dayNum = int.tryParse(match.group(1) ?? '1') ?? 1;
      final date = actualStartDate!.add(Duration(days: dayNum - 1));
      return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
    return '';
  }

  Future<void> deleteSessionLog(String key, int logIndex) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Session Log'),
        content: Text('Are you sure you want to delete this session log? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        if (timingLogs[key] != null && logIndex >= 0 && logIndex < timingLogs[key]!.length) {
          final log = timingLogs[key]![logIndex];
          final duration = Duration(seconds: log['duration'] ?? 0);
          timingLogs[key]!.removeAt(logIndex);
          totalTimes[key] = (totalTimes[key] ?? Duration.zero) - duration;
          if (totalTimes[key]!.inSeconds < 0) totalTimes[key] = Duration.zero;
          if (timingLogs[key]!.isEmpty) {
            totalTimes[key] = Duration.zero;
          }
          saveTiming();
        }
      });
    }
  }

  void clearAllState() {
    setState(() {
      completed = [];
      timingLogs = {};
      totalTimes = {};
      isTiming = {};
      currentStart = {};
      activeKey = null;
      currentSession = Duration.zero;
      notes = {};
      noteControllers = {};
      noteStyles = {};
      noteHighlights = {};
      actualStartDate = null;
      expandedKey = null;
      searchController.clear();
      searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final topics = [
      'All',
      ...{...allItems.map((e) => e.topic)}
    ];
    final priorities = [
      'All',
      ...{...allItems.map((e) => e.priority)}
    ];

    // For progress page
    final completedItems = allItems.where((item) => completed.contains('${item.day}-${item.subtopic}')).toList();
    final completedCount = completedItems.length;
    final totalCount = allItems.length;
    final progressValue = totalCount == 0 ? 0.0 : completedCount / totalCount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Roadmap Tracker'),
        backgroundColor: Colors.blue[800],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by anything (date, title, note, etc.)',
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[800]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Flutter Roadmap', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Menu', style: TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.track_changes, color: Colors.blue[700]),
              title: Text('Progress'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProgressPage(
                      completedCount: completedCount,
                      totalCount: totalCount,
                      completedItems: completedItems,
                      progress: progressValue,
                      notes: notes,
                      timingLogs: timingLogs,
                      totalTimes: totalTimes,
                      onUnmarkComplete: (key) => toggleComplete(key),
                      onResetCard: (key) => resetTimer(key),
                      getDynamicDate: _getDynamicDate,
                      getPriorityColor: getPriorityColor,
                      getNoteStyle: getNoteStyle,
                      isNoteImportant: isNoteImportant,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue[700]),
              title: Text('Settings'),
              onTap: () async {
                Navigator.of(context).pop();
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
                if (result == true) {
                  clearAllState();
                  await loadProgress();
                  await loadTimingSafe();
                  await loadNotesSafe();
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.flag),
        tooltip: 'Jump to next Challenge',
        onPressed: () {
          final nextChallenge = filteredItems
              .indexWhere((item) => item.subtopic.toLowerCase().contains('challenge') && !completed.contains('${item.day}-${item.subtopic}'));
          if (nextChallenge != -1) {
            Scrollable.ensureVisible(
              context,
              duration: Duration(milliseconds: 500),
              alignment: 0.1,
            );
          }
        },
      ),
      body: Container(
        color: Colors.blue[50],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, color: Colors.blue[700]),
                          SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedTopic,
                                borderRadius: BorderRadius.circular(10),
                                items: topics.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                                onChanged: (value) => setState(() => selectedTopic = value!),
                                isExpanded: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedPriority,
                                borderRadius: BorderRadius.circular(10),
                                items: priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                                onChanged: (value) => setState(() => selectedPriority = value!),
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60, color: Colors.blueGrey[200]),
                          SizedBox(height: 16),
                          Text(
                            'No items found for your filter.',
                            style: TextStyle(fontSize: 18, color: Colors.blueGrey[600], fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try changing your search or filters.',
                            style: TextStyle(fontSize: 15, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, idx) {
                        final item = filteredItems[idx];
                        final key = '${item.day}-${item.subtopic}';
                        final isChallenge = item.subtopic.toLowerCase().contains('challenge');
                        final isCompleted = completed.contains(key);
                        final hasSessionLog = (timingLogs[key]?.isNotEmpty ?? false);
                        final isTimerRunning = isTiming[key] == true && activeKey == key;
                        return Card(
                          color: isCompleted ? Colors.green[50] : Colors.white,
                          elevation: 1,
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: getPriorityColor(item.priority, background: true), width: 2),
                          ),
                          child: Stack(
                            children: [
                              ExpansionTile(
                                key: PageStorageKey(key),
                                onExpansionChanged: (expanded) {
                                  setState(() {
                                    expandedKey = expanded ? key : null;
                                  });
                                },
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(item.icon, style: TextStyle(fontSize: 26)),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        item.day,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        item.subtopic,
                                        style: TextStyle(
                                          fontWeight: isChallenge ? FontWeight.bold : FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        overflow: expandedKey == key ? null : TextOverflow.ellipsis,
                                        maxLines: expandedKey == key ? null : 1,
                                      ),
                                    ),
                                    if (isChallenge)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.orange[100],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text('CHALLENGE',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                                        ),
                                      ),
                                    if (isTimerRunning)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.blue[200]!),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.timer, size: 16, color: Colors.blue[700]),
                                              SizedBox(width: 4),
                                              Text(
                                                formatDuration(currentSession),
                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (!isCompleted && !isTimerRunning && hasSessionLog)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text('In Progress',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.topic, style: TextStyle(color: Colors.blueGrey[700], fontSize: 13)),
                                      SizedBox(height: 2),
                                      Text('Date: ${_getDynamicDate(item.day)}', style: TextStyle(color: Colors.blueGrey[400], fontSize: 12)),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text('Priority: ', style: TextStyle(fontSize: 12)),
                                          Text(
                                            item.priority,
                                            style: TextStyle(
                                              color: getPriorityColor(item.priority),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                children: [
                                  if (expandedKey == key)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0, right: 16, top: 0, bottom: 8),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: completed.contains(key),
                                            onChanged: (val) {
                                              toggleComplete(key);
                                            },
                                            activeColor: Colors.green,
                                          ),
                                          Text(
                                            completed.contains(key) ? 'Marked as Read' : 'Mark as Read',
                                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey[800]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Learning Timer', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 15)),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text('Total: ', style: TextStyle(color: Colors.blue[700], fontSize: 13)),
                                            Text(formatDuration(totalTimes[key] ?? Duration.zero),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.play_arrow, color: isTimerRunning ? Colors.grey : Colors.blue[700]),
                                              onPressed: isTimerRunning ? null : () => startTimer(key),
                                              tooltip: 'Start',
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.pause, color: isTimerRunning ? Colors.orange[700] : Colors.grey),
                                              onPressed: isTimerRunning ? () => pauseTimer(key) : null,
                                              tooltip: 'Pause',
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.stop,
                                                  color: (isTimerRunning || (totalTimes[key] ?? Duration.zero) > Duration.zero)
                                                      ? Colors.red[700]
                                                      : Colors.grey),
                                              onPressed: (isTimerRunning || (totalTimes[key] ?? Duration.zero) > Duration.zero)
                                                  ? () => stopTimer(key)
                                                  : null,
                                              tooltip: 'Stop',
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.refresh,
                                                  color: (totalTimes[key] ?? Duration.zero) > Duration.zero || (timingLogs[key]?.isNotEmpty ?? false)
                                                      ? Colors.red
                                                      : Colors.grey),
                                              onPressed: (totalTimes[key] ?? Duration.zero) > Duration.zero || (timingLogs[key]?.isNotEmpty ?? false)
                                                  ? () => resetTimer(key)
                                                  : null,
                                              tooltip: 'Reset',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        if ((timingLogs[key]?.isNotEmpty ?? false)) ...[
                                          Divider(),
                                          Text('Session Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          SizedBox(height: 4),
                                          ...List.generate(timingLogs[key]!.length, (i) {
                                            final log = timingLogs[key]![i];
                                            final start = DateTime.tryParse(log['start'] ?? '') ?? DateTime.now();
                                            final end = DateTime.tryParse(log['end'] ?? '') ?? DateTime.now();
                                            final duration = Duration(seconds: log['duration'] ?? 0);
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')} | '
                                                      'Start: ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} | '
                                                      'End: ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')} | '
                                                      'Duration: ${formatDuration(duration)}',
                                                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.delete, size: 18, color: Colors.red[400]),
                                                    tooltip: 'Delete this session',
                                                    onPressed: () => deleteSessionLog(key, i),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 15)),
                                            if (isNoteImportant(key))
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Icon(Icons.star, color: Colors.orange, size: 20),
                                              ),
                                            Spacer(),
                                            IconButton(
                                              icon: Icon(Icons.edit, size: 18, color: Colors.blue[700]),
                                              onPressed: () => showNoteEditor(context, key),
                                              tooltip: 'Edit Note',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: notes[key]?['highlight'] != null ? Color(notes[key]!['highlight']) : Colors.grey[100],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.blue[50]!),
                                          ),
                                          child: Text(
                                            notes[key]?['text'] ?? 'No notes yet.',
                                            style: getNoteStyle(key),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class ProgressPage extends StatefulWidget {
  final int completedCount;
  final int totalCount;
  final List<RoadmapItem> completedItems;
  final double progress;
  final Map<String, Map<String, dynamic>> notes;
  final Map<String, List<Map<String, dynamic>>> timingLogs;
  final Map<String, Duration> totalTimes;
  final void Function(String key) onUnmarkComplete;
  final void Function(String key) onResetCard;
  final String Function(String day) getDynamicDate;
  final Color Function(String priority, {bool background}) getPriorityColor;
  final TextStyle Function(String key) getNoteStyle;
  final bool Function(String key) isNoteImportant;

  const ProgressPage({
    Key? key,
    required this.completedCount,
    required this.totalCount,
    required this.completedItems,
    required this.progress,
    required this.notes,
    required this.timingLogs,
    required this.totalTimes,
    required this.onUnmarkComplete,
    required this.onResetCard,
    required this.getDynamicDate,
    required this.getPriorityColor,
    required this.getNoteStyle,
    required this.isNoteImportant,
  }) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late List<RoadmapItem> completedItems;

  @override
  void initState() {
    super.initState();
    completedItems = List<RoadmapItem>.from(widget.completedItems);
  }

  void handleUnmarkComplete(String key) {
    widget.onUnmarkComplete(key);
    setState(() {
      completedItems = completedItems.where((item) => '${item.day}-${item.subtopic}' != key).toList();
    });
  }

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = completedItems.length;
    final totalCount = widget.totalCount;
    final progress = totalCount == 0 ? 0.0 : completedCount / totalCount;
    final notes = widget.notes;
    final timingLogs = widget.timingLogs;
    final totalTimes = widget.totalTimes;
    final getDynamicDate = widget.getDynamicDate;
    final getPriorityColor = widget.getPriorityColor;
    final getNoteStyle = widget.getNoteStyle;
    final isNoteImportant = widget.isNoteImportant;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Progress'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.blue[100],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
            ),
            SizedBox(height: 12),
            Text('$completedCount of $totalCount completed', style: TextStyle(fontSize: 16, color: Colors.blueGrey[800])),
            SizedBox(height: 24),
            Text('Completed Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800])),
            SizedBox(height: 8),
            Expanded(
              child: completedItems.isEmpty
                  ? Center(child: Text('No items completed yet.'))
                  : ListView.builder(
                      itemCount: completedItems.length,
                      itemBuilder: (context, idx) {
                        final item = completedItems[idx];
                        final key = '${item.day}-${item.subtopic}';
                        final isChallenge = item.subtopic.toLowerCase().contains('challenge');
                        return Card(
                          color: Colors.green[50],
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ExpansionTile(
                            leading: Text(item.icon, style: TextStyle(fontSize: 26)),
                            title: Row(
                              children: [
                                Text(item.day, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                                SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    item.subtopic,
                                    style: TextStyle(
                                      fontWeight: isChallenge ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                if (isChallenge)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text('CHALLENGE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.topic, style: TextStyle(color: Colors.blueGrey[700], fontSize: 13)),
                                  SizedBox(height: 2),
                                  Text('Date: ${getDynamicDate(item.day)}', style: TextStyle(color: Colors.blueGrey[400], fontSize: 12)),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text('Priority: ', style: TextStyle(fontSize: 12)),
                                      Text(
                                        item.priority,
                                        style: TextStyle(
                                          color: getPriorityColor(item.priority),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Learning Timer', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 15)),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Text('Total: ', style: TextStyle(color: Colors.blue[700], fontSize: 13)),
                                        Text(formatDuration(totalTimes[key] ?? Duration.zero),
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    if ((timingLogs[key]?.isNotEmpty ?? false)) ...[
                                      Divider(),
                                      Text('Session Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      SizedBox(height: 4),
                                      ...timingLogs[key]!.map((log) {
                                        final start = DateTime.tryParse(log['start'] ?? '') ?? DateTime.now();
                                        final end = DateTime.tryParse(log['end'] ?? '') ?? DateTime.now();
                                        final duration = Duration(seconds: log['duration'] ?? 0);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                          child: Text(
                                            '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')} | '
                                            'Start: ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} | '
                                            'End: ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')} | '
                                            'Duration: ${formatDuration(duration)}',
                                            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 15)),
                                        if (isNoteImportant(key))
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Icon(Icons.star, color: Colors.orange, size: 20),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: notes[key]?['highlight'] != null ? Color(notes[key]!['highlight']) : Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.blue[50]!),
                                      ),
                                      child: Text(
                                        notes[key]?['text'] ?? 'No notes yet.',
                                        style: getNoteStyle(key),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        handleUnmarkComplete(key);
                                      },
                                      icon: Icon(Icons.mark_email_unread, color: Colors.white),
                                      label: Text('Mark as Unread'),
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[700]),
                                    ),
                                    SizedBox(width: 16),
                                    ElevatedButton.icon(
                                      onPressed: () => widget.onResetCard(key),
                                      icon: Icon(Icons.refresh, color: Colors.white),
                                      label: Text('Reset Card'),
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoadmapItem {
  final String day;
  final String topic;
  final String subtopic;
  final String icon;
  final String priority;
  final String estimatedTime;

  RoadmapItem({
    required this.day,
    required this.topic,
    required this.subtopic,
    required this.icon,
    required this.priority,
    required this.estimatedTime,
  });
}
