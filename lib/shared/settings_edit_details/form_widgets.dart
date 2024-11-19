// lib/shared/widgets/form_widgets.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class FormWidgets {
  static Widget buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: AppTheme.bodyLarge,
            decoration: AppTheme.getInputDecoration(
              hint: hint,
              icon: icon ?? Icons.edit_outlined,
            ).copyWith(suffixIcon: suffixIcon),
            validator: validator,
          ),
        ],
      ),
    );
  }

  static Widget buildSubmitButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: AppTheme.primaryButtonStyle,
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(text, style: AppTheme.buttonTextStyle),
      ),
    );
  }

  static Widget buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        message,
        style: AppTheme.bodyMedium.copyWith(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}
