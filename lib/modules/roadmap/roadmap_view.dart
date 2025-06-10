import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import '../../theme/theme_preference.dart';
import '../../modules/settings/settings_view.dart';
import '../../theme/app_colors.dart';
import 'roadmap_model.dart';
import 'roadmap_controller.dart';

class RoadmapView extends StatefulWidget {
  final ThemePreference themePreference;
  final Function(ThemePreference) onThemeChanged;

  const RoadmapView({
    Key? key,
    required this.themePreference,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  _RoadmapViewState createState() => _RoadmapViewState();
}

class _RoadmapViewState extends State<RoadmapView> {
  late RoadmapController _controller;
  late RoadmapModel _model;

  @override
  void initState() {
    super.initState();
    _model = RoadmapModel();
    _controller = RoadmapController(_model);
    _controller.onTimerUpdate = () {
      setState(() {
        // This will rebuild the UI when timer updates
      });
    };
    _controller.loadProgress();
    _controller.loadTimingSafe();
    _controller.loadNotesSafe();
    _controller.loadActualStartDate();
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
        title: Text('Roadmap Tracker'),
        backgroundColor: appBarColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextField(
              controller: _controller.searchController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Search by anything (date, title, note, etc.)',
                hintStyle: TextStyle(color: AppColors.getTextHintColor(isDark)),
                prefixIcon: Icon(Icons.search, color: AppColors.getTextHintColor(isDark)),
                suffixIcon: _controller.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: AppColors.getTextHintColor(isDark)),
                        onPressed: () {
                          setState(() {
                            _controller.searchController.clear();
                            _controller.searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.getInputBackgroundColor(isDark),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _controller.searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: appBarColor),
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
              leading: Icon(Icons.track_changes, color: AppColors.primaryAccent),
              title: Text('Progress'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProgressPage(
                      completedCount: _controller.completedItems.length,
                      totalCount: _controller.allItems.length,
                      completedItems: _controller.completedItems,
                      progress: _controller.progress,
                      notes: _controller.notes,
                      timingLogs: _controller.timingLogs,
                      totalTimes: _controller.totalTimes,
                      onUnmarkComplete: (key) => _controller.toggleComplete(key),
                      onResetCard: (key) => _controller.resetTimer(key),
                      getDynamicDate: _controller.getDynamicDate,
                      getPriorityColor: _controller.getPriorityColor,
                      getNoteStyle: _controller.getNoteStyle,
                      isNoteImportant: _controller.isNoteImportant,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: AppColors.primaryAccent),
              title: Text('Settings'),
              onTap: () async {
                Navigator.of(context).pop();
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsView(
                      themePreference: widget.themePreference,
                      onThemeChanged: widget.onThemeChanged,
                    ),
                  ),
                );
                if (result == true) {
                  _controller.clearAllState();
                  await _controller.loadProgress();
                  await _controller.loadTimingSafe();
                  await _controller.loadNotesSafe();
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryDark,
        child: Icon(Icons.flag),
        tooltip: 'Jump to next Challenge',
        onPressed: () {
          final nextChallenge = _controller.filteredItems.indexWhere(
              (item) => item.subtopic.toLowerCase().contains('challenge') && !_controller.completed.contains('${item.day}-${item.subtopic}'));
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
        color: backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color: cardColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, color: AppColors.primaryAccent),
                          SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _controller.selectedTopic,
                                borderRadius: BorderRadius.circular(10),
                                items: _controller.topics.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                                onChanged: (value) => setState(() => _controller.selectedTopic = value!),
                                isExpanded: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _controller.selectedPriority,
                                borderRadius: BorderRadius.circular(10),
                                items: _controller.priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                                onChanged: (value) => setState(() => _controller.selectedPriority = value!),
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
              child: _controller.filteredItems.isEmpty
                  ? Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.getDividerColor(isDark)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60, color: AppColors.getTextHintColor(isDark)),
                          SizedBox(height: 16),
                          Text(
                            'No items found for your filter.',
                            style: TextStyle(fontSize: 18, color: AppColors.getTextSecondaryColor(isDark), fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try changing your search or filters.',
                            style: TextStyle(fontSize: 15, color: AppColors.getTextHintColor(isDark)),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _controller.filteredItems.length,
                      itemBuilder: (context, idx) {
                        final item = _controller.filteredItems[idx];
                        final key = '${item.day}-${item.subtopic}';
                        final isChallenge = item.subtopic.toLowerCase().contains('challenge');
                        final isCompleted = _controller.completed.contains(key);
                        final hasSessionLog = (_controller.timingLogs[key]?.isNotEmpty ?? false);
                        final isTimerRunning = _controller.isTiming[key] == true && _controller.activeKey == key;

                        return Card(
                          color: isCompleted ? AppColors.successLight : cardColor,
                          elevation: 1,
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: _controller.getPriorityColor(item.priority, background: true), width: 2),
                          ),
                          child: Stack(
                            children: [
                              ExpansionTile(
                                key: PageStorageKey(key),
                                onExpansionChanged: (expanded) {
                                  setState(() {
                                    _controller.expandedKey = expanded ? key : null;
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
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        item.subtopic,
                                        style: TextStyle(
                                          fontWeight: isChallenge ? FontWeight.bold : FontWeight.normal,
                                          color: textColor,
                                        ),
                                        overflow: _controller.expandedKey == key ? null : TextOverflow.ellipsis,
                                        maxLines: _controller.expandedKey == key ? null : 1,
                                      ),
                                    ),
                                    if (isChallenge)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.challengeLight,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text('CHALLENGE',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.challenge)),
                                        ),
                                      ),
                                    if (isTimerRunning)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.infoLight,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: AppColors.info),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.timer, size: 16, color: AppColors.info),
                                              SizedBox(width: 4),
                                              Text(
                                                _controller.formatDuration(_controller.currentSession),
                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.info),
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
                                            color: AppColors.infoLight,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child:
                                              Text('In Progress', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.info)),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.topic, style: TextStyle(color: subtitleColor, fontSize: 13)),
                                      SizedBox(height: 2),
                                      Text('Date: ${_controller.getDynamicDate(item.day)}',
                                          style: TextStyle(color: AppColors.getTextHintColor(isDark), fontSize: 12)),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text('Priority: ', style: TextStyle(fontSize: 12)),
                                          Text(
                                            item.priority,
                                            style: TextStyle(
                                              color: _controller.getPriorityColor(item.priority),
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
                                  if (_controller.expandedKey == key)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0, right: 16, top: 0, bottom: 8),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: _controller.completed.contains(key),
                                            onChanged: (val) {
                                              _controller.toggleComplete(key);
                                              setState(() {});
                                            },
                                            activeColor: AppColors.success,
                                          ),
                                          Text(
                                            _controller.completed.contains(key) ? 'Marked as Read' : 'Mark as Read',
                                            style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.getTextSecondaryColor(isDark)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Learning Timer',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark, fontSize: 15)),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text('Total: ', style: TextStyle(color: AppColors.primaryAccent, fontSize: 13)),
                                            Text(_controller.formatDuration(_controller.totalTimes[key] ?? Duration.zero),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.play_arrow,
                                                  color: isTimerRunning ? AppColors.getTextHintColor(isDark) : AppColors.primaryAccent),
                                              onPressed: isTimerRunning
                                                  ? null
                                                  : () {
                                                      _controller.startTimer(key);
                                                      setState(() {});
                                                    },
                                              tooltip: 'Start',
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.pause,
                                                  color: isTimerRunning ? AppColors.timerPaused : AppColors.getTextHintColor(isDark)),
                                              onPressed: isTimerRunning
                                                  ? () {
                                                      _controller.pauseTimer(key);
                                                      setState(() {});
                                                    }
                                                  : null,
                                              tooltip: 'Pause',
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.stop,
                                                  color: (isTimerRunning || (_controller.totalTimes[key] ?? Duration.zero) > Duration.zero)
                                                      ? AppColors.timerStopped
                                                      : AppColors.getTextHintColor(isDark)),
                                              onPressed: (isTimerRunning || (_controller.totalTimes[key] ?? Duration.zero) > Duration.zero)
                                                  ? () {
                                                      _controller.stopTimer(key);
                                                      setState(() {});
                                                    }
                                                  : null,
                                              tooltip: 'Stop',
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.refresh,
                                                  color: (_controller.totalTimes[key] ?? Duration.zero) > Duration.zero ||
                                                          (_controller.timingLogs[key]?.isNotEmpty ?? false)
                                                      ? AppColors.error
                                                      : AppColors.getTextHintColor(isDark)),
                                              onPressed: (_controller.totalTimes[key] ?? Duration.zero) > Duration.zero ||
                                                      (_controller.timingLogs[key]?.isNotEmpty ?? false)
                                                  ? () => _controller.resetTimer(key)
                                                  : null,
                                              tooltip: 'Reset',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        if ((_controller.timingLogs[key]?.isNotEmpty ?? false)) ...[
                                          Divider(),
                                          Text('Session Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          SizedBox(height: 4),
                                          ...List.generate(_controller.timingLogs[key]!.length, (i) {
                                            final log = _controller.timingLogs[key]![i];
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
                                                      'Duration: ${_controller.formatDuration(duration)}',
                                                      style: TextStyle(fontSize: 12, color: AppColors.getTextSecondaryColor(isDark)),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.delete, size: 18, color: AppColors.error),
                                                    tooltip: 'Delete this session',
                                                    onPressed: () => _controller.deleteSessionLog(key, i),
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
                                            Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark, fontSize: 15)),
                                            if (_controller.isNoteImportant(key))
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Icon(Icons.star, color: AppColors.warning, size: 20),
                                              ),
                                            Spacer(),
                                            IconButton(
                                              icon: Icon(Icons.edit, size: 18, color: AppColors.primaryAccent),
                                              onPressed: () => _controller.showNoteEditor(context, key),
                                              tooltip: 'Edit Note',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: _controller.notes[key]?['highlight'] != null
                                                ? Color(_controller.notes[key]!['highlight'])
                                                : cardColor,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: AppColors.getDividerColor(isDark)),
                                          ),
                                          child: Text(
                                            _controller.notes[key]?['text'] ?? 'No notes yet.',
                                            style: _controller.getNoteStyle(key).copyWith(
                                                  color: isDark ? AppColors.darkTextPrimary : _controller.getNoteStyle(key).color,
                                                ),
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

// ProgressPage class (simplified for now)
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
  late int completedCount;
  late double progress;

  @override
  void initState() {
    super.initState();
    completedItems = List<RoadmapItem>.from(widget.completedItems);
    completedCount = widget.completedCount;
    progress = widget.progress;
  }

  @override
  void didUpdateWidget(ProgressPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.completedItems != widget.completedItems) {
      setState(() {
        completedItems = List<RoadmapItem>.from(widget.completedItems);
        completedCount = widget.completedCount;
        progress = widget.progress;
      });
    }
  }

  void handleUnmarkComplete(String key) async {
    widget.onUnmarkComplete(key);
    setState(() {
      completedItems = completedItems.where((item) => '${item.day}-${item.subtopic}' != key).toList();
      completedCount = completedItems.length;
      progress = completedCount / widget.totalCount.clamp(1, widget.totalCount);
    });
  }

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
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
        title: Text('Your Progress'),
        backgroundColor: appBarColor,
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.blue[900])),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.blue[100],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
            ),
            SizedBox(height: 12),
            Text('$completedCount of ${widget.totalCount} completed', style: TextStyle(fontSize: 16, color: Colors.blueGrey[800])),
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
                          color: isDark ? Color(0xFF2D2D2D) : Colors.green[50],
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
                                  Text(item.topic, style: TextStyle(color: subtitleColor, fontSize: 13)),
                                  SizedBox(height: 2),
                                  Text('Date: ${widget.getDynamicDate(item.day)}', style: TextStyle(color: Colors.blueGrey[400], fontSize: 12)),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text('Priority: ', style: TextStyle(fontSize: 12)),
                                      Text(
                                        item.priority,
                                        style: TextStyle(
                                          color: widget.getPriorityColor(item.priority),
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
                                        Text(formatDuration(widget.totalTimes[key] ?? Duration.zero),
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    if ((widget.timingLogs[key]?.isNotEmpty ?? false)) ...[
                                      Divider(),
                                      Text('Session Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      SizedBox(height: 4),
                                      ...widget.timingLogs[key]!.map((log) {
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
                                        if (widget.isNoteImportant(key))
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
                                        color: widget.notes[key]?['highlight'] != null ? Color(widget.notes[key]!['highlight']) : Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.blue[50]!),
                                      ),
                                      child: Text(
                                        widget.notes[key]?['text'] ?? 'No notes yet.',
                                        style: widget.getNoteStyle(key),
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
