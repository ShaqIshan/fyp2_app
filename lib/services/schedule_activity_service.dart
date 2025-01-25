import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/screens/child_screens/child_visual_schedule_screen/utils/schedule_time_helper.dart';

class ScheduleActivityService {
  static Future<bool> isNextActivity(Schedule schedule) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final schedulePeriod =
        ScheduleTimeHelper.getPeriodFromDateTime(schedule.startTime);

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('schedules')
          .where('startTime', isGreaterThan: Timestamp.fromDate(now))
          .where('startTime', isLessThan: Timestamp.fromDate(tomorrow))
          .orderBy('startTime')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      // Filter schedules to only include those in the same period as the current schedule
      final schedules = querySnapshot.docs
          .map((doc) => Schedule(
                id: doc.id,
                childId: doc['childId'],
                name: doc['name'],
                date: (doc['startTime'] as Timestamp).toDate(),
                startTime: (doc['startTime'] as Timestamp).toDate(),
                endTime: (doc['endTime'] as Timestamp).toDate(),
                category: doc['category'] ?? 'Activity',
              ))
          .where((s) =>
              ScheduleTimeHelper.getPeriodFromDateTime(s.startTime) ==
              schedulePeriod)
          .toList();

      if (schedules.isEmpty) {
        return false;
      }

      return schedule.id == schedules.first.id;
    } catch (e) {
      print('Error checking next activity: $e');
      return false;
    }
  }
}
