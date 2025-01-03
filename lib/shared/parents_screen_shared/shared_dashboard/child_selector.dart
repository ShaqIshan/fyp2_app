// lib/widgets/child_selector.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/parents_models/child_profile.dart';
import '../../app_theme.dart';

class ChildSelector extends StatelessWidget {
  final String selectedChildId;
  final Function(String) onChildSelected;
  final VoidCallback onAddNewChild;
  final Stream<QuerySnapshot> childrenStream;

  const ChildSelector({
    Key? key,
    required this.selectedChildId,
    required this.onChildSelected,
    required this.onAddNewChild,
    required this.childrenStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: childrenStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final children = snapshot.data?.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ChildProfile(
                id: doc.id,
                name: data['name'] ?? 'Unnamed Child',
                textToSpeechEnabled: data['textToSpeechEnabled'] ?? true,
              );
            }).toList() ??
            [];

        return PopupMenuButton<String>(
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onSelected: (String value) {
            if (value == 'add_new') {
              onAddNewChild();
            } else {
              onChildSelected(value);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                children
                    .firstWhere(
                      (child) => child.id == selectedChildId,
                      orElse: () => ChildProfile(
                        id: '',
                        name: 'Select Child',
                        textToSpeechEnabled: true,
                      ),
                    )
                    .name,
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
                  value: child.id,
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
                            child.name[0].toUpperCase(),
                            style: AppTheme.titleMedium.copyWith(
                              color: AppTheme.accentGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        child.name,
                        style: AppTheme.titleMedium,
                      ),
                      if (child.id == selectedChildId) const Spacer(),
                      if (child.id == selectedChildId)
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
