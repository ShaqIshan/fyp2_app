import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class TimeInputSection extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;
  final Function(int) onDurationSelected;
  final int? selectedDuration;

  const TimeInputSection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onDurationSelected,
    this.selectedDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTimeSelector(
                context: context,
                label: 'Start Time',
                time: startTime,
                onTimeChanged: onStartTimeChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTimeSelector(
                context: context,
                label: 'End Time',
                time: endTime,
                onTimeChanged: onEndTimeChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        QuickDurationSelector(
          onDurationSelected: onDurationSelected,
          selectedDuration: selectedDuration,
        ),
      ],
    );
  }

  Widget _buildTimeSelector({
    required BuildContext context,
    required String label,
    required TimeOfDay time,
    required Function(TimeOfDay) onTimeChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (picked != null) {
              onTimeChanged(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time.format(context),
                  style: AppTheme.bodyLarge,
                ),
                const Icon(Icons.access_time, color: AppTheme.secondaryBrown),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QuickDurationSelector extends StatelessWidget {
  final Function(int) onDurationSelected;
  final int? selectedDuration;

  const QuickDurationSelector({
    super.key,
    required this.onDurationSelected,
    this.selectedDuration,
  });

  static const List<Map<String, dynamic>> _durations = [
    {'minutes': 15, 'label': '15min'},
    {'minutes': 30, 'label': '30min'},
    {'minutes': 45, 'label': '45min'},
    {'minutes': 60, 'label': '1h'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Duration', style: AppTheme.bodyMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _durations.map((duration) {
              final bool isSelected = selectedDuration == duration['minutes'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSelected ? AppTheme.accentGreen : Colors.white,
                    foregroundColor:
                        isSelected ? Colors.white : AppTheme.secondaryBrown,
                    elevation: isSelected ? 2 : 0,
                    side: BorderSide(
                      color: isSelected
                          ? AppTheme.accentGreen
                          : AppTheme.secondaryBrown.withOpacity(0.2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () => onDurationSelected(duration['minutes']),
                  child: Text(
                    duration['label'],
                    style: AppTheme.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
