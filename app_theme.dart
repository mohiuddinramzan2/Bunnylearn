// lib/models/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFFF6B9D);
  static const Color secondary = Color(0xFFFFCA57);
  static const Color accent1 = Color(0xFF6C5CE7);
  static const Color accent2 = Color(0xFF00B894);
  static const Color accent3 = Color(0xFF0984E3);
  static const Color bgLight = Color(0xFFFFF8FF);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textMid = Color(0xFF666666);
  static const Color textLight = Color(0xFFAAAAAA);

  static const List<Color> sectionColors = [
    Color(0xFFFF6B6B),
    Color(0xFFFF9F43),
    Color(0xFF6C5CE7),
    Color(0xFF00B894),
  ];
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      background: AppColors.bgLight,
    ),
    textTheme: GoogleFonts.fredokaOneTextTheme().copyWith(
      bodyMedium: GoogleFonts.nunito(fontSize: 16, color: AppColors.textDark),
      bodySmall: GoogleFonts.nunito(fontSize: 13, color: AppColors.textMid),
    ),
    scaffoldBackgroundColor: AppColors.bgLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.fredokaOne(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

// Reusable text styles
class AppTextStyles {
  static TextStyle get heading => GoogleFonts.fredokaOne(
    fontSize: 28,
    color: AppColors.textDark,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get subHeading => GoogleFonts.fredokaOne(
    fontSize: 20,
    color: AppColors.textDark,
  );

  static TextStyle get bigLetter => GoogleFonts.fredokaOne(
    fontSize: 64,
    color: Colors.white,
    height: 1,
  );

  static TextStyle get cardTitle => GoogleFonts.fredokaOne(
    fontSize: 18,
    color: AppColors.textDark,
  );

  static TextStyle get body => GoogleFonts.nunito(
    fontSize: 16,
    color: AppColors.textDark,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get caption => GoogleFonts.nunito(
    fontSize: 13,
    color: AppColors.textMid,
  );

  static TextStyle get emoji => const TextStyle(fontSize: 48);
  static TextStyle get emojiLarge => const TextStyle(fontSize: 72);
  static TextStyle get emojiSmall => const TextStyle(fontSize: 28);
}
