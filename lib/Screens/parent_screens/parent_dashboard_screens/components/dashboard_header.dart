import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/screens/onboarding_screens/child_name/child_name_input.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/activity_card_styles.dart';

class DashboardHeader extends StatelessWidget {
  final String? selectedChildId;
  final Stream<QuerySnapshot> childrenStream;
  final Function(String) onChildSelected;
  final VoidCallback onSettingsPressed;

  const DashboardHeader({
    super.key,
    required this.selectedChildId,
    required this.childrenStream,
    required this.onChildSelected,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
      decoration: ActivityStyles.headerGradient,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildChildSelector(context),
              ),
              IconButton(
                onPressed: onSettingsPressed,
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChildSelector(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: childrenStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error loading children',
            style: AppTheme.bodyMedium.copyWith(color: Colors.white),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        final children = snapshot.data?.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'id': doc.id,
                'name': data['name'] ?? 'Unnamed Child',
              };
            }).toList() ??
            [];

        return PopupMenuButton<String>(
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onSelected: (String value) {
            if (value == 'add_new') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ChildNameInput(isFromDashboard: true),
                ),
              );
            } else {
              onChildSelected(value);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                children.firstWhere(
                  (child) => child['id'] == selectedChildId,
                  orElse: () => {'id': '', 'name': 'Select Child'},
                )['name']!,
                style: AppTheme.displayLarge.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
          itemBuilder: (BuildContext context) => [
            ...children.map((child) => PopupMenuItem<String>(
                  value: child['id'],
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.accentGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            (child['name'] as String)[0].toUpperCase(),
                            style: AppTheme.titleMedium.copyWith(
                              color: AppTheme.accentGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        child['name'] as String,
                        style: AppTheme.titleMedium,
                      ),
                      if (child['id'] == selectedChildId) const Spacer(),
                      if (child['id'] == selectedChildId)
                        const Icon(
                          Icons.check,
                          color: AppTheme.accentGreen,
                          size: 20,
                        ),
                    ],
                  ),
                )),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'add_new',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.accentGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: AppTheme.accentGreen,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Add New Child',
                    style: AppTheme.titleMedium.copyWith(
                      color: AppTheme.accentGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
