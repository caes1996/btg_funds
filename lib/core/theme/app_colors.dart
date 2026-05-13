import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static AppColors get instance => AppColors._();

  // ── Light palette ──
  static const Color primary = Color(0xFF00A859);
  static const Color primaryDark = Color(0xFF007B43);
  static const Color primaryLight = Color(0xFF4DC88A);

  static const Color accent = Color(0xFF1A3C6D);
  static const Color accentLight = Color(0xFF2E5A9E);

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57C00);

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);

  static const Color fpvBadge = Color(0xFF00A859);
  static const Color ficBadge = Color(0xFF1A3C6D);

  static const Color subscribeAmount = Color(0xFFD32F2F);
  static const Color cancelAmount = Color(0xFF2E7D32);

  // ── Dark palette ──
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color darkPrimary = Color(0xFF4DC88A);
  static const Color darkAccent = Color(0xFF6B9FD6);
  static const Color darkAccentLight = Color(0xFF3A6FA0);

  static const Color darkError = Color(0xFFEF5350);
  static const Color darkSuccess = Color(0xFF66BB6A);
  static const Color darkWarning = Color(0xFFFFA726);

  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextHint = Color(0xFF6B6B6B);

  static const Color darkDivider = Color(0xFF3C3C3C);
  static const Color darkDisabled = Color(0xFF5A5A5A);

  static const Color darkFpvBadge = Color(0xFF246042);
  static const Color darkFicBadge = Color(0xFF46698E);

  static const Color darkSubscribeAmount = Color(0xFFEF5350);
  static const Color darkCancelAmount = Color(0xFF66BB6A);
}