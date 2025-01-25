import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../../../../services/level_progress_service.dart';
import 'components/child_home_header.dart';
import 'components/journey_path.dart';
import 'models/level_data.dart';
import 'models/level_progress.dart';
import 'dart:async';

class ChildJourneyHome extends StatefulWidget {
  const ChildJourneyHome({super.key});

  @override
  State<ChildJourneyHome> createState() => _ChildJourneyHomeState();
}

class _ChildJourneyHomeState extends State<ChildJourneyHome> {
  final LevelProgressService _progressService = LevelProgressService();
  late StreamSubscription<DocumentSnapshot> _userSubscription; // Add this line
  late List<LevelData> levels;
  int totalStars = 0;
  String? currentChildId;

  @override
  void initState() {
    super.initState();
    levels = LevelData.getLevels();
    _getCurrentChild();
    _listenToSelectedChild(); // Add this line
  }

  Future<void> _getCurrentChild() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      // First get the user document to get the selected child ID
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) return;

      final selectedChildId = userDoc.data()?['selectedChildId'] as String?;
      if (selectedChildId == null) return;

      // Set the current child ID for progress tracking
      currentChildId = selectedChildId;
      _progressService.setCurrentChildId(selectedChildId);
      await _initializeProgress();
    } catch (e) {
      print('Error getting current child: $e');
    }
  }

  void _listenToSelectedChild() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    _userSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((userDoc) {
      if (!userDoc.exists) return;

      final selectedChildId = userDoc.data()?['selectedChildId'] as String?;
      if (selectedChildId != null && selectedChildId != currentChildId) {
        setState(() {
          currentChildId = selectedChildId;
          _progressService.setCurrentChildId(selectedChildId);
          _initializeProgress();
        });
      }
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  Future<void> _initializeProgress() async {
    try {
      await _progressService.initializeUserProgress();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to initialize progress: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleLevelComplete(int levelId, int stars) async {
    final progress = LevelProgress(
      levelId: levelId,
      isCompleted: true,
      earnedStars: stars,
      isUnlocked: true,
    );

    await _progressService.updateLevelProgress(progress);
  }

  void _handleLevelRedo(LevelData level) async {
    final shouldStart = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.replay_circle_filled_rounded,
              size: 80,
              color: AppTheme.childTurquoise,
            ),
            const SizedBox(height: 16),
            Text(
              'Let\'s Play Again!',
              style: AppTheme.childHeadingMedium.copyWith(
                color: AppTheme.childTurquoise,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ready to have more fun with ${level.name}?',
              textAlign: TextAlign.center,
              style: AppTheme.childBodyText,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Not Now',
                    style: AppTheme.childBodyText.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.childSoftGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Let\'s Go!',
                    style: AppTheme.childBodyText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (shouldStart == true) {
      _startLevel(level);
    }
  }

  void _startLevel(LevelData level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => level.getGameScreen(
          onComplete: (score) {
            if (mounted) {
              _handleLevelComplete(level.id, score);
            }
          },
          onNext: () {
            if (!mounted) return;

            if (level.id == 6) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChildJourneyHome(),
                ),
                (route) => false,
              );
              return;
            }

            final nextIndex = levels.indexWhere((l) => l.id == level.id) + 1;
            if (nextIndex < levels.length) {
              _startLevel(levels[nextIndex]);
            }
          },
        ),
      ),
    );
  }

  void _handleLevelTap(LevelData level) {
    if (!level.isUnlocked) return;

    if (level.isCompleted) {
      _handleLevelRedo(level);
    } else {
      _startLevel(level);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: StreamBuilder<List<LevelProgress>>(
          stream: _progressService.getLevelProgress(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong!',
                  style: AppTheme.childBodyText.copyWith(
                    color: Colors.red,
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final progress = snapshot.data!;
            totalStars = progress.fold(
              0,
              (sum, level) => sum + level.earnedStars,
            );

            // Update levels with progress data
            levels = levels.map((level) {
              final levelProgress = progress.firstWhere(
                (p) => p.levelId == level.id,
                orElse: () => LevelProgress(levelId: level.id),
              );

              return level.copyWith(
                isCompleted: levelProgress.isCompleted,
                isUnlocked: levelProgress.isUnlocked,
                earnedStars: levelProgress.earnedStars,
              );
            }).toList();

            return Column(
              children: [
                ChildHomeHeader(
                  totalStars: totalStars,
                  maxStars: levels.length * 5,
                ),
                Expanded(
                  child: JourneyPath(
                    levels: levels,
                    onLevelTap: _handleLevelTap,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
