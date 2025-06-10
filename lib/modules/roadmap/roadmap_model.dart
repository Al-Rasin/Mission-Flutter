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

class RoadmapModel {
  final List<RoadmapItem> allItems = [
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
}
