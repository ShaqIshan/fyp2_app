import 'package:flutter/material.dart';

import '../../../../../../shared/app_theme.dart';

class RemoveSection extends StatelessWidget {
  final String profileName;
  final VoidCallback onRemove;

  const RemoveSection({
    super.key,
    required this.profileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          'Remove Profile',
          style: AppTheme.titleMedium.copyWith(
            color: Colors.red,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.red,
        ),
        onTap: onRemove,
      ),
    );
  }
}
