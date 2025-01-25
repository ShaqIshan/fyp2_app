import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/child_screens/child_home_screen/home/models/level_progress.dart';

class LevelProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _currentChildId;

  // Set current child ID
  void setCurrentChildId(String childId) {
    _currentChildId = childId;
  }

  // Get reference to the current child's progress collection
  CollectionReference<Map<String, dynamic>> _getUserProgressCollection() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('No authenticated user');
    if (_currentChildId == null) throw Exception('No child selected');

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('children')
        .doc(_currentChildId)
        .collection('levelProgress');
  }

  Future<void> initializeUserProgress() async {
    try {
      if (_currentChildId == null) throw Exception('No child selected');

      final progressCollection = _getUserProgressCollection();

      // Check if progress already exists
      final snapshot = await progressCollection.get();
      if (snapshot.docs.isNotEmpty) return; // Already initialized

      // Create batch write
      final batch = _firestore.batch();

      // Initialize first level as unlocked
      final firstLevel = LevelProgress(levelId: 1, isUnlocked: true);
      final firstLevelDoc = progressCollection.doc('1');
      batch.set(firstLevelDoc, firstLevel.toMap());

      // Initialize remaining levels as locked
      for (int i = 2; i <= 6; i++) {
        final level = LevelProgress(levelId: i);
        final levelDoc = progressCollection.doc(i.toString());
        batch.set(levelDoc, level.toMap());
      }

      // Commit the batch
      await batch.commit();
    } catch (e) {
      print('Error initializing user progress: $e');
      throw Exception('Failed to initialize user progress: ${e.toString()}');
    }
  }

  Stream<List<LevelProgress>> getLevelProgress() {
    try {
      if (_currentChildId == null) {
        return Stream.value([]); // Return empty list if no child selected
      }

      return _getUserProgressCollection().orderBy('levelId').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => LevelProgress.fromMap(doc.data()))
              .toList());
    } catch (e) {
      print('Error getting level progress: $e');
      throw Exception('Failed to get level progress');
    }
  }

  Future<void> updateLevelProgress(LevelProgress progress) async {
    try {
      if (_currentChildId == null) throw Exception('No child selected');

      final progressCollection = _getUserProgressCollection();

      final updateData = {
        'levelId': progress.levelId,
        'isCompleted': progress.isCompleted,
        'earnedStars': progress.earnedStars,
        'isUnlocked': progress.isUnlocked,
        'lastPlayed': DateTime.now().toIso8601String(),
      };

      // Update the current level
      await progressCollection
          .doc(progress.levelId.toString())
          .set(updateData, SetOptions(merge: true));

      // If this level is completed, unlock the next level
      if (progress.isCompleted && progress.levelId < 6) {
        final nextLevelId = progress.levelId + 1;
        final nextLevelRef = progressCollection.doc(nextLevelId.toString());

        final nextLevelDoc = await nextLevelRef.get();

        if (nextLevelDoc.exists) {
          await nextLevelRef.update({
            'isUnlocked': true,
            'lastPlayed': DateTime.now().toIso8601String(),
          });
        } else {
          await nextLevelRef.set({
            'levelId': nextLevelId,
            'isUnlocked': true,
            'isCompleted': false,
            'earnedStars': 0,
            'lastPlayed': DateTime.now().toIso8601String(),
          });
        }
      }
    } catch (e) {
      print('Error updating level progress: $e');
      throw Exception('Failed to update level progress');
    }
  }

  Future<int> getTotalStars() async {
    try {
      if (_currentChildId == null) return 0;

      final snapshot = await _getUserProgressCollection().get();
      return snapshot.docs.fold<int>(
        0,
        (sum, doc) => sum + (doc.data()['earnedStars'] as int? ?? 0),
      );
    } catch (e) {
      print('Error getting total stars: $e');
      return 0;
    }
  }
}
