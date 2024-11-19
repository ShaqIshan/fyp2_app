// lib/screens/parent_screens/visual_schedule/add_schedule_screen.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  int? _selectedCategoryIndex;
  bool _showCalendar = false;

  // final List<Map<String, dynamic>> _categories = [
  //   // {'name': 'Eat', 'imagePath': 'assets/images/eat.png'},
  //   // {'name': 'Sleep', 'imagePath': 'assets/images/sleep.png'},
  //   // {'name': 'Play', 'imagePath': 'assets/images/play.png'},
  //   // {'name': 'Exercise', 'imagePath': 'assets/images/exercise.png'},
  // ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Learn', 'icon': Icons.school},
    {'name': 'Play', 'icon': Icons.sports_esports},
    {'name': 'Sleep', 'icon': Icons.bedtime},
    {'name': 'Eat', 'icon': Icons.restaurant},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryBrown),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Schedule',
          style: AppTheme.headingMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                child: _buildDateCard(),
              ),
              const SizedBox(height: 16),

              // Animated Calendar
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: _showCalendar
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    firstDay:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    focusedDay: _selectedDate,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, _selectedDate),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _showCalendar = false; // Hide calendar after selection
                      });
                    },
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                  ),
                ),
                secondChild: const SizedBox(height: 0),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: _buildTimeSelector(
                      label: 'Start Time',
                      time: _startTime,
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: _startTime,
                        );
                        if (picked != null) {
                          setState(() {
                            _startTime = picked;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTimeSelector(
                      label: 'End Time',
                      time: _endTime,
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: _endTime,
                        );
                        if (picked != null) {
                          setState(() {
                            _endTime = picked;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text('Category', style: AppTheme.titleMedium),
              const SizedBox(height: 16),
              _buildCategoryGrid(),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: AppTheme.primaryButtonStyle,
                  onPressed: () {
                    // TODO: Save schedule and return but with firebase
                    if (_validateInputs()) {
                      _printScheduleDetails();
                    }
                  },
                  child: const Text(
                    'Add Schedule',
                    style: AppTheme.buttonTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard() {
    return Container(
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
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            style: AppTheme.titleMedium,
          ),
          const Icon(Icons.calendar_today, color: AppTheme.secondaryBrown),
        ],
      ),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
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

  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryItem(index);
      },
    );
  }

  Widget _buildCategoryItem(int index) {
    final bool isSelected = _selectedCategoryIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentGreen
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _categories[index]['icon'],
              color:
                  isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              _categories[index]['name'],
              style: AppTheme.bodyMedium.copyWith(
                color:
                    isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
// print all the fields for now

  void _printScheduleDetails() {
    // Format date and times for readable output
    String formattedDate =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
    String formattedStartTime = "${_startTime.hour}:${_startTime.minute}";
    String formattedEndTime = "${_endTime.hour}:${_endTime.minute}";

    // Get category name if one is selected
    String? selectedCategory = _selectedCategoryIndex != null
        ? _categories[_selectedCategoryIndex!]['name']
        : null;

    // Print all values
    print('\n--- New Schedule Details ---');
    print('Activity Name: ${_nameController.text}');
    print('Date: $formattedDate');
    print('Start Time: $formattedStartTime');
    print('End Time: $formattedEndTime');
    print('Category: ${selectedCategory ?? "Not selected"}');
    print('-------------------------\n');

    // Show a snackbar to indicate the schedule was "added"
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Schedule details printed to console'),
        backgroundColor: AppTheme.accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
      ),
    );

    // TODO: Later implementation notes
    // - Add state management to store schedule data
    // - Implement Firebase integration to save schedules
    // - Add validation before saving
    // - Include user ID when saving schedule
    // - Add error handling
  }

  bool _validateInputs() {
    if (_nameController.text.trim().isEmpty) {
      _showError('Please enter an activity name');
      return false;
    }

    if (_endTime.hour < _startTime.hour ||
        (_endTime.hour == _startTime.hour &&
            _endTime.minute <= _startTime.minute)) {
      _showError('End time must be after start time');
      return false;
    }

    if (_selectedCategoryIndex == null) {
      _showError('Please select a category');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
