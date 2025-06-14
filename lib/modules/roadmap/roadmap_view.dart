import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import '../../theme/theme_preference.dart';
import '../../modules/settings/settings_view.dart';
import '../../theme/app_colors.dart';
import '../../utils/confirmation_dialog.dart';
import '../../utils/app_button.dart';
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
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    _model = RoadmapModel();
    _controller = RoadmapController(_model);
    _controller.onTimerUpdate = () {
      if (mounted) setState(() {});
    };
    _controller.onNoteUpdate = () {
      if (mounted) setState(() {});
    };
    _controller.loadProgress();
    _controller.loadTimingSafe();
    _controller.loadNotesSafe();
    _controller.loadActualStartDate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        title: Text('Mission Flutter'),
        backgroundColor: appBarColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(72),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            decoration: BoxDecoration(
              color: appBarColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _controller.searchController,
                style: TextStyle(color: isDark ? Colors.white : AppColors.lightTextPrimary, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search roadmap items...',
                  hintStyle: TextStyle(color: isDark ? Colors.white70 : AppColors.lightTextHint, fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: isDark ? Colors.white70 : AppColors.lightTextSecondary, size: 24),
                  suffixIcon: _controller.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: isDark ? Colors.white70 : AppColors.lightTextSecondary, size: 20),
                          onPressed: () {
                            setState(() {
                              _controller.searchController.clear();
                              _controller.searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
      ),
      drawer: Drawer(
        backgroundColor: cardColor,
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Mission Flutter',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Learning Roadmap',
                        style: TextStyle(
                          color: AppColors.getTextSecondaryColor(Theme.of(context).brightness == Brightness.dark),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 16),
                children: [
                  _buildDrawerItem(
                    icon: Icons.track_changes,
                    title: 'Progress',
                    subtitle: 'View your learning progress',
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
                  _buildDrawerItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    subtitle: 'App preferences and data',
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: Icon(Icons.flag, size: 20),
        label: Text('Next Challenge'),
        onPressed: () {
          // Find the next incomplete challenge in the filtered list
          final nextChallengeIndex = _controller.filteredItems.indexWhere(
              (item) => item.subtopic.toLowerCase().contains('challenge') && !_controller.completed.contains('${item.day}-${item.subtopic}'));

          if (nextChallengeIndex != -1) {
            final nextChallengeItem = _controller.filteredItems[nextChallengeIndex];
            final nextChallengeKey = '${nextChallengeItem.day}-${nextChallengeItem.subtopic}';

            // Scroll to the specific item using its GlobalKey
            if (_itemKeys.containsKey(nextChallengeKey)) {
              final targetKey = _itemKeys[nextChallengeKey]!;
              final targetContext = targetKey.currentContext;

              if (targetContext != null) {
                Scrollable.ensureVisible(
                  targetContext,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  alignment: 0.1,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Found next challenge: ${nextChallengeItem.subtopic}'),
                    backgroundColor: AppColors.challenge,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No more challenges available!'),
                backgroundColor: AppColors.info,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundColor, backgroundColor.withOpacity(0.8)],
                )
              : null,
          color: isDark ? null : backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.getDividerColor(isDark)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Flexible(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _controller.selectedTopic,
                              isExpanded: true,
                              hint: Text('Topic', style: TextStyle(fontSize: 13, color: subtitleColor)),
                              items: _controller.topics
                                  .map((t) => DropdownMenuItem(value: t, child: Text(t, style: TextStyle(fontSize: 13, color: textColor))))
                                  .toList(),
                              onChanged: (value) => setState(() => _controller.selectedTopic = value!),
                              icon: Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.getTextHintColor(isDark)),
                              style: TextStyle(fontSize: 13, color: textColor),
                              dropdownColor: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _controller.selectedPriority,
                              isExpanded: true,
                              hint: Text('Priority', style: TextStyle(fontSize: 13, color: subtitleColor)),
                              items: _controller.priorities
                                  .map((p) => DropdownMenuItem(value: p, child: Text(p, style: TextStyle(fontSize: 13, color: textColor))))
                                  .toList(),
                              onChanged: (value) => setState(() => _controller.selectedPriority = value!),
                              icon: Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.getTextHintColor(isDark)),
                              style: TextStyle(fontSize: 13, color: textColor),
                              dropdownColor: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _controller.filteredItems.isEmpty
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.all(32),
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black.withOpacity(0.3) : AppColors.lightTextHint.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.getTextHintColor(isDark).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.search_off,
                                size: 48,
                                color: AppColors.getTextHintColor(isDark),
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'No items found',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Try adjusting your search or filters',
                              style: TextStyle(
                                fontSize: 16,
                                color: subtitleColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _controller.filteredItems.length,
                      itemBuilder: (context, idx) {
                        final item = _controller.filteredItems[idx];
                        final key = '${item.day}-${item.subtopic}';
                        final isChallenge = item.subtopic.toLowerCase().contains('challenge');
                        final isCompleted = _controller.completed.contains(key);
                        final hasSessionLog = (_controller.timingLogs[key]?.isNotEmpty ?? false);
                        final isTimerRunning = _controller.isTiming[key] == true && _controller.activeKey == key;
                        final isTimerPaused = _controller.isTimerPaused(key);

                        // Ensure we have a GlobalKey for this item
                        if (!_itemKeys.containsKey(key)) {
                          _itemKeys[key] = GlobalKey();
                        }

                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Header section (always visible)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.expandedKey = _controller.expandedKey == key ? null : key;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: isCompleted ? AppColors.success.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            item.icon,
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item.subtopic,
                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                          fontWeight: FontWeight.w600,
                                                          color: isCompleted ? AppColors.success : Theme.of(context).textTheme.titleMedium?.color,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: _controller.getPriorityColor(item.priority),
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    item.priority,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: _controller.getPriorityColor(item.priority),
                                                    ),
                                                  ),
                                                ),
                                                if (isChallenge) ...[
                                                  SizedBox(width: 8),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.deepOrange,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Text(
                                                      'CHALLENGE',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.deepOrange,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    item.topic,
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                                                        ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          AnimatedRotation(
                                            turns: _controller.expandedKey == key ? 0.25 : 0,
                                            duration: Duration(milliseconds: 300),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          if (isCompleted)
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: AppColors.success.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'Completed',
                                                style: TextStyle(
                                                  color: AppColors.success,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          if (isTimerRunning || isTimerPaused) ...[
                                            if (isCompleted) SizedBox(height: 4),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: isTimerRunning ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: isTimerRunning ? AppColors.success.withOpacity(0.3) : AppColors.warning.withOpacity(0.3)),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    isTimerRunning ? Icons.timer : Icons.pause,
                                                    size: 12,
                                                    color: isTimerRunning ? AppColors.success : AppColors.warning,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    _controller.formatDuration(_controller.currentSession),
                                                    style: TextStyle(
                                                      color: isTimerRunning ? AppColors.success : AppColors.warning,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Expandable content
                              AnimatedCrossFade(
                                firstChild: SizedBox.shrink(),
                                secondChild: Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Timer section
                                      _buildTimerSection(item, key),
                                      SizedBox(height: 20),
                                      // Notes section
                                      _buildNotesSection(item, key),
                                      SizedBox(height: 20),
                                      // Action buttons
                                      _buildActionButtons(item, key),
                                    ],
                                  ),
                                ),
                                crossFadeState: _controller.expandedKey == key ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 300),
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.getTextPrimaryColor(isDark);
    final subtitleColor = AppColors.getTextSecondaryColor(isDark);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: AppColors.primary,
                  width: 3,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 24),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.getTextHintColor(isDark),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerSection(RoadmapItem item, String key) {
    final isTimerRunning = _controller.isTiming[key] == true && _controller.activeKey == key;
    final isTimerPaused = _controller.isTimerPaused(key);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timer_outlined, size: 20, color: AppColors.primary),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Learning Timer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getTextPrimaryColor(Theme.of(context).brightness == Brightness.dark),
                ),
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Total: ${_controller.formatDuration(_controller.totalTimes[key] ?? Duration.zero)}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimerButton(
              icon: Icons.play_arrow,
              color: isTimerRunning ? AppColors.getTextHintColor(Theme.of(context).brightness == Brightness.dark) : AppColors.success,
              onPressed: isTimerRunning
                  ? null
                  : () {
                      if (_controller.activeKey == key && _controller.currentSession > Duration.zero) {
                        _controller.resumeTimer(key);
                      } else {
                        _controller.startTimer(key);
                      }
                      setState(() {});
                    },
              tooltip: isTimerRunning
                  ? 'Running'
                  : (_controller.activeKey == key && _controller.currentSession > Duration.zero)
                      ? 'Resume'
                      : 'Start',
            ),
            _buildTimerButton(
              icon: Icons.pause,
              color: isTimerRunning ? AppColors.warning : AppColors.getTextHintColor(Theme.of(context).brightness == Brightness.dark),
              onPressed: isTimerRunning
                  ? () {
                      _controller.pauseTimer(key);
                      setState(() {});
                    }
                  : null,
              tooltip: isTimerPaused ? 'Paused' : 'Pause',
            ),
            _buildTimerButton(
              icon: Icons.stop,
              color:
                  (isTimerRunning || isTimerPaused) ? AppColors.error : AppColors.getTextHintColor(Theme.of(context).brightness == Brightness.dark),
              onPressed: (isTimerRunning || isTimerPaused)
                  ? () {
                      _controller.stopTimer(key);
                      setState(() {});
                    }
                  : null,
              tooltip: 'Stop',
            ),
            _buildTimerButton(
              icon: Icons.refresh,
              color: (_controller.totalTimes[key] ?? Duration.zero) > Duration.zero || (_controller.timingLogs[key]?.isNotEmpty ?? false)
                  ? AppColors.error
                  : AppColors.getTextHintColor(Theme.of(context).brightness == Brightness.dark),
              onPressed: (_controller.totalTimes[key] ?? Duration.zero) > Duration.zero || (_controller.timingLogs[key]?.isNotEmpty ?? false)
                  ? () => _showResetConfirmation(key, item.subtopic)
                  : null,
              tooltip: 'Reset',
            ),
          ],
        ),
        if ((_controller.timingLogs[key]?.isNotEmpty ?? false)) ...[
          SizedBox(height: 16),
          Divider(),
          Row(
            children: [
              Icon(Icons.history, size: 16, color: AppColors.getTextSecondaryColor(Theme.of(context).brightness == Brightness.dark)),
              SizedBox(width: 8),
              Text(
                'Session History',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getTextPrimaryColor(Theme.of(context).brightness == Brightness.dark),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...List.generate(_controller.timingLogs[key]!.length, (i) {
            final log = _controller.timingLogs[key]![i];
            final start = DateTime.tryParse(log['start'] ?? '') ?? DateTime.now();
            final end = DateTime.tryParse(log['end'] ?? '') ?? DateTime.now();
            final duration = Duration(seconds: log['duration'] ?? 0);
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.getBackgroundColor(Theme.of(context).brightness == Brightness.dark),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.getDividerColor(Theme.of(context).brightness == Brightness.dark)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${start.month}/${start.day} | ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')} | ${_controller.formatDuration(duration)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.getTextSecondaryColor(Theme.of(context).brightness == Brightness.dark),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, size: 16, color: AppColors.error),
                    onPressed: () => _controller.deleteSessionLog(key, i),
                    tooltip: 'Delete session',
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildTimerButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: onPressed != null ? color.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
        border: onPressed != null ? Border.all(color: color.withOpacity(0.3)) : null,
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        color: color,
        onPressed: onPressed,
        tooltip: tooltip,
      ),
    );
  }

  Future<void> _showResetConfirmation(String key, String itemName) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Reset Timer',
      message:
          'Are you sure you want to reset the timer for "$itemName"?\n\nThis will clear:\n• All session history\n• Total time tracking\n\nThis action cannot be undone.',
      confirmText: 'Reset',
      cancelText: 'Cancel',
      confirmColor: AppColors.error,
    );

    if (confirmed == true) {
      _controller.resetTimer(key);
      setState(() {});
    }
  }

  Widget _buildNotesSection(RoadmapItem item, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.note_outlined, size: 20, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.getTextPrimaryColor(Theme.of(context).brightness == Brightness.dark),
              ),
            ),
            if (_controller.isNoteImportant(key)) ...[
              SizedBox(width: 8),
              Icon(Icons.star, size: 16, color: AppColors.warning),
            ],
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: IconButton(
                icon: Icon(Icons.edit_outlined, size: 16),
                color: AppColors.primary,
                onPressed: () => _controller.showNoteEditor(context, key, onNoteSaved: () {
                  setState(() {});
                }),
                tooltip: 'Edit Note',
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _controller.notes[key]?['highlight'] != null
                ? Color(_controller.notes[key]!['highlight']).withOpacity(0.1)
                : AppColors.getBackgroundColor(Theme.of(context).brightness == Brightness.dark),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _controller.notes[key]?['highlight'] != null
                  ? Color(_controller.notes[key]!['highlight']).withOpacity(0.3)
                  : AppColors.getDividerColor(Theme.of(context).brightness == Brightness.dark),
            ),
          ),
          child: Text(
            _controller.notes[key]?['text'] ?? 'No notes yet. Tap the edit button to add notes.',
            style: _controller.getNoteStyle(key).copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  fontSize: 14,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(RoadmapItem item, String key) {
    final isCompleted = _controller.completed.contains(key);

    return Row(
      children: [
        Flexible(
          child: AppButton(
            onPressed: () async {
              await _controller.toggleComplete(key);
              setState(() {}); // Update UI after toggle
            },
            text: isCompleted ? 'Mark as Unread' : 'Mark as Read',
            backgroundColor: isCompleted ? AppColors.warning : AppColors.success,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        SizedBox(width: 8),
        Flexible(
          child: AppButton(
            onPressed: () => _showResetConfirmation(key, item.subtopic),
            text: 'Reset Card',
            backgroundColor: AppColors.error,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
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

  Future<void> _showResetConfirmation(String key, String itemName) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Reset Timer',
      message:
          'Are you sure you want to reset the timer for "$itemName"?\n\nThis will clear:\n• All session history\n• Total time tracking\n\nThis action cannot be undone.',
      confirmText: 'Reset',
      cancelText: 'Cancel',
      confirmColor: AppColors.error,
    );

    if (confirmed == true) {
      widget.onResetCard(key);
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
                                      child: Text(
                                        'CHALLENGE',
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                                      ),
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
                                    AppButton(
                                      onPressed: () {
                                        handleUnmarkComplete(key);
                                      },
                                      text: 'Mark as Unread',
                                      backgroundColor: Colors.orange[700],
                                      textColor: Colors.white,
                                    ),
                                    SizedBox(width: 16),
                                    AppButton(
                                      onPressed: () => _showResetConfirmation(key, item.subtopic),
                                      text: 'Reset Card',
                                      backgroundColor: Colors.red[700],
                                      textColor: Colors.white,
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
