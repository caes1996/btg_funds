import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  const AppTextStyles._();

  static AppTextStyles get instance => AppTextStyles._();

  // Display
  static TextStyle get displayLarge => GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2, letterSpacing: -0.5);
  static TextStyle get displayMedium => GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold, height: 1.25, letterSpacing: -0.25);
  static TextStyle get displaySmall => GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);

  // Headline
  static TextStyle get headlineLarge => GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w600, height: 1.3);
  static TextStyle get headlineMedium => GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600, height: 1.35);
  static TextStyle get headlineSmall => GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600, height: 1.35);

  // Title
  static TextStyle get titleLarge => GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500, height: 1.4);
  static TextStyle get titleMedium => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4);
  static TextStyle get titleSmall => GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, height: 1.4);

  // Body
  static TextStyle get bodyLarge => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
  static TextStyle get bodyMedium => GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
  static TextStyle get bodySmall => GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, height: 1.45);

  // Label
  static TextStyle get labelLarge => GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.5);
  static TextStyle get labelMedium => GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.5);
  static TextStyle get labelSmall => GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.5);

  // Currency
  static TextStyle get currency => GoogleFonts.jetBrainsMono(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2, color: AppColors.primary);
  static TextStyle get currencySmall => GoogleFonts.jetBrainsMono(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3);
}
