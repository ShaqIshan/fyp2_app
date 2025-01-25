import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:intl/intl.dart';

class ScheduleItemCard extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ScheduleItemCard({
    super.key,
    required this.schedule,
    required this.onDelete,
    required this.onEdit,
  });

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'learn':
        return Icons.school;
      case 'play':
        return Icons.sports_esports;
      case 'sleep':
        return Icons.bedtime;
      case 'eat':
        return Icons.restaurant;
      case 'bath':
        return Icons.bathtub;
      case 'exercise':
        return Icons.fitness_center;
      case 'medicine':
        return Icons.medication;
      case 'dress':
        return Icons.checkroom;
      default:
        return Icons.event_note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(schedule.id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppTheme.accentGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete Schedule'),
                content: Text(
                  'Are you sure you want to delete "${schedule.name}"?',
                  style: AppTheme.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          onEdit();
          return false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(schedule.category),
              color: AppTheme.accentGreen,
              size: 24,
            ),
          ),
          title: Text(
            schedule.name,
            style: AppTheme.titleMedium,
          ),
          subtitle: Text(
            '${DateFormat.jm().format(schedule.startTime)} - ${DateFormat.jm().format(schedule.endTime)}',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              schedule.category ?? 'Activity',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.accentGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
