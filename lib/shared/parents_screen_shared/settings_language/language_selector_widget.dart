// Improved language selector with better UI and separated widget class
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

// Simplified language selector optimized for two languages
class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.language,
              color: AppTheme.secondaryBrown,
            ),
            title: Text(
              'Language',
              style: AppTheme.bodyLarge.copyWith(
                color: AppTheme.textDark,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.secondaryBrown.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                _buildLanguageOption(
                  'English',
                  isSelected: selectedLanguage == 'English',
                  isFirst: true,
                ),
                _buildLanguageOption(
                  'Malay',
                  isSelected: selectedLanguage == 'Malay',
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    String language, {
    bool isSelected = false,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onLanguageChanged(language),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.accentGreen : Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: isFirst ? const Radius.circular(12) : Radius.zero,
              right: isLast ? const Radius.circular(12) : Radius.zero,
            ),
          ),
          child: Text(
            language,
            style: AppTheme.bodyMedium.copyWith(
              color: isSelected ? Colors.white : AppTheme.secondaryBrown,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
