// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors for Parents interface
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

  // child layouts colors and fonts

  static const Color childSkyBlue = Color(0xFFE3F2FD); // Background
  static const Color childTurquoise = Color(0xFF4ECDC4); // Primary actions
  static const Color childPurple = Color(0xFF9B7EDE); // Secondary actions
  static const Color childOrange = Color(0xFFFFB347); // Interactive elements
  static const Color childYellow = Color(0xFFFFBE0B); // Rewards/achievements
  static const Color childSoftGreen = Color(0xFF95D5B2); // Success states
  static const Color childPink = Color(0xFFFF6B6B); // Highlights
  static const Color childCream = Color(0xFFFFF9F0); // Content areas

// Helper method for child text styles
  static TextStyle getChildTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.nunito(
      // Nunito is a child-friendly font
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? childTurquoise,
      height: height,
    );
  }

// Child-specific text styles
  static TextStyle get childHeadingLarge => getChildTextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get childHeadingMedium => getChildTextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get childTitleLarge => getChildTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get childBodyText => getChildTextStyle(
        fontSize: 18,
      );

// Child-specific button style
  static final ButtonStyle childPrimaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: childTurquoise,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // More rounded for child UI
    ),
    elevation: 0, // Flat design for cleaner look
  );

// Child-specific card decoration
  static BoxDecoration get childCardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

// Child-specific input decoration
  static InputDecoration getChildInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: childBodyText.copyWith(
        color: childTurquoise.withOpacity(0.5),
      ),
      prefixIcon: Icon(icon, color: childTurquoise),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: childTurquoise),
      ),
    );
  }
}
