import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'roadmap_model.dart';

class RoadmapController {
  final RoadmapModel model;

  // State variables
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
  DateTime? actualStartDate;

  RoadmapController(this.model);

  List<RoadmapItem> get allItems => model.allItems;
  List<RoadmapItem> get completedItems => allItems.where((item) => completed.contains('${item.day}-${item.subtopic}')).toList();
  double get progress => completed.length / allItems.length.clamp(1, allItems.length);

  List<String> get topics => [
        'All',
        ...{...allItems.map((e) => e.topic)}
      ];
  List<String> get priorities => [
        'All',
        ...{...allItems.map((e) => e.priority)}
      ];

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

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    completed = prefs.getStringList('completedItems') ?? [];
  }

  Future<void> toggleComplete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (completed.contains(key)) {
      completed.remove(key);
    } else {
      completed.add(key);
      if (key == 'Day 1-Install SDK' && actualStartDate == null) {
        saveActualStartDate(DateTime.now());
      }
    }
    await prefs.setStringList('completedItems', completed);
  }

  Future<void> loadActualStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final millis = prefs.getInt('actualStartDate');
    if (millis != null) {
      actualStartDate = DateTime.fromMillisecondsSinceEpoch(millis);
    }
  }

  Future<void> saveActualStartDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('actualStartDate', date.millisecondsSinceEpoch);
    actualStartDate = date;
  }

  Future<void> loadTiming() async {
    final prefs = await SharedPreferences.getInstance();
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
  }

  Future<void> saveTiming() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('timingLogs', jsonEncode(timingLogs));
    await prefs.setString('totalTimes', jsonEncode(totalTimes.map((k, v) => MapEntry(k, v.inSeconds))));
  }

  void startTimer(String key) {
    if (isTiming[key] == true) return;
    isTiming[key] = true;
    currentStart[key] = DateTime.now();
    activeKey = key;
    if (key == 'Day 1-Install SDK' && actualStartDate == null) {
      saveActualStartDate(DateTime.now());
    }
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      currentSession += Duration(seconds: 1);
    });
  }

  void pauseTimer(String key) {
    if (isTiming[key] != true) return;
    timer?.cancel();
    final start = currentStart[key];
    if (start != null) {
      final end = DateTime.now();
      final duration = end.difference(start);
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
      saveTiming();
    }
  }

  void stopTimer(String key) {
    pauseTimer(key);
    currentSession = Duration.zero;
    activeKey = null;
  }

  Future<void> resetTimer(String key) async {
    totalTimes[key] = Duration.zero;
    timingLogs[key] = [];
    isTiming[key] = false;
    currentStart[key] = null;
    currentSession = Duration.zero;
    saveTiming();
  }

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString('notes');
    if (notesString != null) {
      final notesMap = jsonDecode(notesString) as Map<String, dynamic>;
      notes = notesMap.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v)));
    }
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes', jsonEncode(notes));
  }

  void updateNote(String key, String text, TextStyle style, Color? highlight, bool important) {
    notes[key] = {
      'text': text,
      'fontSize': style.fontSize ?? 16.0,
      'color': style.color?.value ?? Colors.black.value,
      'bold': style.fontWeight == FontWeight.bold,
      'italic': style.fontStyle == FontStyle.italic,
      'highlight': highlight?.value,
      'important': important,
    };
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
        final isDark = Theme.of(context).brightness == Brightness.dark;
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
                        hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        fillColor: isDark ? Color(0xFF2D2D2D) : (highlight ?? Colors.white),
                        filled: true,
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
    try {
      await loadTiming();
    } catch (e) {
      // If error, clear old/corrupt data and reload
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('timingLogs');
      await prefs.remove('totalTimes');
      timingLogs = {};
      totalTimes = {};
    }
  }

  Future<void> loadNotesSafe() async {
    try {
      await loadNotes();
    } catch (e) {
      // If error, clear old/corrupt data and reload
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('notes');
      notes = {};
    }
  }

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

  String getDynamicDate(String day) {
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
  }

  void clearAllState() {
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
  }
}
