// lib/services/schedule_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/schedule.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add a new schedule
  Future<void> addSchedule(Schedule schedule) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('No user logged in');

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('schedules')
          .add(schedule.toMap());
    } catch (e) {
      print('Error adding schedule: $e');
      throw Exception('Failed to add schedule');
    }
  }

  // Get schedules for a specific child
  Stream<List<Schedule>> getChildSchedules(String childId) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('No user logged in');

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('schedules')
        .where('childId', isEqualTo: childId)
        .orderBy('date')
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Schedule.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Get upcoming schedules (next 24 hours)
  Stream<List<Schedule>> getUpcomingSchedules(String childId) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('No user logged in');
    if (childId.isEmpty) return Stream.value([]);

    print('Getting schedules for childId: $childId'); // Debug print

    // Get current date (not time)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Get date 3 days from now to include today, tomorrow and day after
    final threeDaysFromNow = today.add(const Duration(days: 3));

    try {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('schedules')
          .where('childId', isEqualTo: childId)
          .orderBy('startTime')
          .snapshots()
          .map((snapshot) {
        print('Found ${snapshot.docs.length} schedules'); // Debug print
        snapshot.docs.forEach((doc) {
          print('Schedule data: ${doc.data()}'); // Print each schedule
        });

        try {
          final schedules = snapshot.docs
              .map((doc) => Schedule.fromMap(doc.id, doc.data()))
              .where((schedule) {
            // Include schedules from today up to 3 days ahead
            final scheduleDate = DateTime(schedule.startTime.year,
                schedule.startTime.month, schedule.startTime.day);
            return scheduleDate.isAtSameMomentAs(today) ||
                (scheduleDate.isAfter(today) &&
                    scheduleDate.isBefore(threeDaysFromNow));
          }).toList()
            ..sort((a, b) => a.startTime.compareTo(b.startTime));
          return schedules.take(5).toList();
        } catch (e) {
          print('Error parsing schedule data: $e');
          return [];
        }
      });
    } catch (e) {
      print('Error getting upcoming schedules: $e');
      return Stream.value([]);
    }
  }

  // Delete a schedule
  Future<void> deleteSchedule(String scheduleId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('No user logged in');

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('schedules')
          .doc(scheduleId)
          .delete();
    } catch (e) {
      print('Error deleting schedule: $e');
      throw Exception('Failed to delete schedule');
    }
  }

  // Update a schedule
  Future<void> updateSchedule(Schedule schedule) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('No user logged in');

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('schedules')
          .doc(schedule.id)
          .update(schedule.toMap());
    } catch (e) {
      print('Error updating schedule: $e');
      throw Exception('Failed to update schedule');
    }
  }

  // Get schedules for a specific date
  Stream<List<Schedule>> getSchedulesForDate(String childId, DateTime date) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('No user logged in');

    // Create DateTime objects for start and end of the selected date
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('schedules')
        .where('childId', isEqualTo: childId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('date')
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Schedule.fromMap(doc.id, doc.data()))
            .toList());
  }
}
