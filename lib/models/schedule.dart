// lib/models/schedule.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final String childId;
  final String name;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String category;

  Schedule({
    required this.id,
    required this.childId,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'name': name,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'category': category,
    };
  }

  factory Schedule.fromMap(String id, Map<String, dynamic> map) {
    try {
      return Schedule(
        id: id,
        childId: map['childId'] ?? '',
        name: map['name'] ?? '',
        date: (map['date'] as Timestamp).toDate(),
        startTime: (map['startTime'] as Timestamp).toDate(),
        endTime: (map['endTime'] as Timestamp).toDate(),
        category: map['category'] ?? '',
      );
    } catch (e) {
      print('Error creating Schedule from map: $e');
      rethrow;
    }
  }
}
