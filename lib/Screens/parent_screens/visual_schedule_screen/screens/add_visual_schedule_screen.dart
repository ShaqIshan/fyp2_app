import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/models/schedule_categories.dart';
import 'package:fyp2_app/services/schedule_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../components/category_grid.dart';
import '../components/schedule_calendar.dart';
import '../components/time_input_section.dart';
import '../utils/schedule_helpers.dart';

class AddScheduleScreen extends StatefulWidget {
  final String selectedChildId;
  final DateTime? initialDate;

  const AddScheduleScreen({
    super.key,
    required this.selectedChildId,
    this.initialDate,
  });

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _scheduleService = ScheduleService();
  final _nameController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  ScheduleCategory? _selectedCategory;
  bool _showCalendar = false;
  bool _isLoading = false;
  int? _selectedDuration; // Added to track selected quick duration

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay(
      hour: _startTime.hour + 1,
      minute: _startTime.minute,
    );
  }

  void _handleStartTimeChanged(TimeOfDay time) {
    setState(() {
      _startTime = time;
      // Reset selected duration when manually changing time
      _selectedDuration = null;
      // Auto-update end time to be 30 minutes later if no duration is selected
      if (_selectedDuration == null) {
        _endTime = ScheduleHelpers.addDurationToTime(time, 30);
      }
    });
  }

  void _handleEndTimeChanged(TimeOfDay time) {
    setState(() {
      _endTime = time;
      // Reset selected duration when manually changing end time
      _selectedDuration = null;
    });
  }

  void _handleDurationSelected(int minutes) {
    setState(() {
      _selectedDuration = minutes;
      _endTime = ScheduleHelpers.addDurationToTime(_startTime, minutes);
    });
  }

  IconData _getDefaultCategoryIcon() {
    return Icons.event_note; // Default icon when no category is selected
  }

  Future<void> _saveSchedule() async {
    print(
        'Creating schedule for childId: ${widget.selectedChildId}'); // Debug print
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      final startDateTime = ScheduleHelpers.combineDateAndTime(
        _selectedDate,
        _startTime,
      );
      final endDateTime = ScheduleHelpers.combineDateAndTime(
        _selectedDate,
        _endTime,
      );

      print('Start time: $startDateTime'); // Debug print
      print('End time: $endDateTime'); // Debug print

      // Get existing schedules for conflict check
      final existingSchedules = await _scheduleService
          .getSchedulesForDate(widget.selectedChildId, _selectedDate)
          .first;

      print(
          'Existing schedules count: ${existingSchedules.length}'); // Debug print

      // Check for time conflicts
      final hasConflict = await ScheduleHelpers.hasTimeConflict(
        existingSchedules,
        startDateTime,
        endDateTime,
      );

      if (hasConflict) {
        _showError('This time slot overlaps with another activity');
        return;
      }

      final schedule = Schedule(
        id: '',
        childId: widget.selectedChildId,
        name: _nameController.text.trim(),
        date: _selectedDate,
        startTime: startDateTime,
        endTime: endDateTime,
        category: _selectedCategory?.name ?? 'Activity',
      );

      print('Creating schedule with data: ${schedule.toMap()}'); // Debug prints

      await _scheduleService.addSchedule(schedule);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schedule added successfully'),
            backgroundColor: AppTheme.accentGreen,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      _showError('Failed to add schedule: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _validateInputs() {
    if (_nameController.text.trim().isEmpty) {
      _showError('Please enter an activity name');
      return false;
    }

    if (!ScheduleHelpers.isValidTimeRange(_startTime, _endTime)) {
      _showError('End time must be after start time');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.creamBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.primaryBrown),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Add Schedule', style: AppTheme.headingMedium),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name', style: AppTheme.titleMedium),
              TextFormField(
                controller: _nameController,
                decoration: AppTheme.getInputDecoration(
                  hint: 'Enter activity name',
                  icon: Icons.edit_outlined,
                ),
                style: AppTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Text('Date', style: AppTheme.titleMedium),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showCalendar = !_showCalendar;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: AppTheme.titleMedium,
                      ),
                      const Icon(Icons.calendar_today,
                          color: AppTheme.secondaryBrown),
                    ],
                  ),
                ),
              ),
              if (_showCalendar) ...[
                const SizedBox(height: 16),
                ScheduleCalendar(
                  selectedDay: _selectedDate,
                  focusedDay: _selectedDate,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _showCalendar = false;
                    });
                  },
                  showInContainer: false,
                ),
              ],
              const SizedBox(height: 24),
              TimeInputSection(
                startTime: _startTime,
                endTime: _endTime,
                onStartTimeChanged: _handleStartTimeChanged,
                onEndTimeChanged: _handleEndTimeChanged,
                onDurationSelected: _handleDurationSelected,
                selectedDuration: _selectedDuration,
              ),
              const SizedBox(height: 24),
              CategoryGrid(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: AppTheme.primaryButtonStyle,
                  onPressed: _isLoading ? null : _saveSchedule,
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text(
                          'Add Schedule',
                          style: AppTheme.buttonTextStyle,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
