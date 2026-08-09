import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography(this._textTheme);

  final TextTheme _textTheme;

  TextStyle get display => _textTheme.displayLarge!;
  TextStyle get heading => _textTheme.headlineMedium!;
  TextStyle get title => _textTheme.titleLarge!;
  TextStyle get body => _textTheme.bodyLarge!;
  TextStyle get caption => _textTheme.bodyMedium!;
  TextStyle get label => _textTheme.labelSmall!;

  static TextTheme createTextTheme({
    required Color text,
    required Color subtitle,
  }) {
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: text,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: text,
        height: 1.25,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: text,
        height: 1.3,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: text,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: subtitle,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: subtitle,
        height: 1.3,
      ),
    );
  }
}

extension AppTypographyExtension on BuildContext {
  AppTypography get typography => AppTypography(Theme.of(this).textTheme);
}
