// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color creamBackground = Color(0xFFF5F1E8);
  static const Color primaryBrown = Color(0xFF8B7355);
  static const Color secondaryBrown = Color(0xFFAA9884);
  static const Color accentGreen = Color(0xFF7C8F6F);
  static const Color textDark = Color(0xFF4A4031);

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: primaryBrown,
  );

  static const TextStyle subheadingStyle = TextStyle(
    color: secondaryBrown,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get displayLarge => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryBrown,
        letterSpacing: -0.5,
      );

  static TextStyle get headingLarge => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryBrown,
      );

  static TextStyle get headingMedium => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryBrown,
      );

  static TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: secondaryBrown,
      );

  static TextStyle get titleMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: secondaryBrown,
      );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16,
        color: textDark,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14,
        color: textDark,
      );

  // Helper method to modify styles
  static TextStyle modifyStyle(
    TextStyle baseStyle, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return baseStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: accentGreen,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );

  // Input Decoration
  static InputDecoration getInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: textDark.withOpacity(0.5)),
      prefixIcon: Icon(icon, color: secondaryBrown),
      filled: true,
      fillColor: Colors.white,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: focusedBorder,
    );
  }

  // borders
  static final defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: secondaryBrown.withOpacity(0.1)),
  );

  static final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: accentGreen),
  );
}
