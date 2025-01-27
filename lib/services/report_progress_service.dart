import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProgress({
    required String childId,
    int? starsCollected,
    int? minutesPlayed,
  }) async {
    final today = DateTime.now().toString().split(' ')[0];
    final progressRef = _firestore.collection('children').doc(childId);

    // Start a batch write
    final batch = _firestore.batch();

    // Update today's progress
    final todayDoc = progressRef.collection('progress').doc(today);
    batch.set(
      todayDoc,
      {
        if (starsCollected != null)
          'starsCollected': FieldValue.increment(starsCollected),
        if (minutesPlayed != null)
          'minutesPlayed': FieldValue.increment(minutesPlayed),
      },
      SetOptions(merge: true),
    );

    // Update weekly progress
    final weeklyDoc = progressRef.collection('progress').doc('weekly');
    batch.set(
      weeklyDoc,
      {
        'days': FieldValue.arrayUnion([today]),
      },
      SetOptions(merge: true),
    );

    // Update daily progress count
    final dailyDoc = progressRef.collection('progress').doc('daily');
    batch.set(
      dailyDoc,
      {
        'daysPlayed': FieldValue.increment(1),
        'totalDays': 30, // You can adjust this value
      },
      SetOptions(merge: true),
    );

    // Commit the batch
    await batch.commit();
  }

  Future<void> resetDailyProgress(String childId) async {
    final today = DateTime.now().toString().split(' ')[0];
    await _firestore
        .collection('children')
        .doc(childId)
        .collection('progress')
        .doc(today)
        .set({
      'starsCollected': 0,
      'minutesPlayed': 0,
    });
  }

  Future<void> resetWeeklyProgress(String childId) async {
    await _firestore
        .collection('children')
        .doc(childId)
        .collection('progress')
        .doc('weekly')
        .set({
      'days': [],
    });
  }
}
