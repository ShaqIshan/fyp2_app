import 'package:flutter/material.dart';

import '../../../../../../shared/app_theme.dart';

class CommunicationSection extends StatelessWidget {
  final bool textToSpeechEnabled;
  final ValueChanged<bool> onTextToSpeechChanged;

  const CommunicationSection({
    super.key,
    required this.textToSpeechEnabled,
    required this.onTextToSpeechChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Communication Board',
          style: AppTheme.titleLarge.copyWith(
            color: AppTheme.primaryBrown,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  'Text-to-Speech',
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.textDark,
                  ),
                ),
                value: textToSpeechEnabled,
                onChanged: onTextToSpeechChanged,
                activeColor: AppTheme.accentGreen,
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  'Communication Board Grid',
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.textDark,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.secondaryBrown,
                ),
                onTap: () {
                  // Grid navigation will be implemented later
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
