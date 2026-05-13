import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  AppColors get appColors => AppColors.instance;
  AppTextStyles get appTextStyles => AppTextStyles.instance;

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  Color get primary => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get accent => isDark ? AppColors.darkAccent : AppColors.accent;
  Color get bgSurface => isDark ? AppColors.darkSurface : AppColors.surface;
  Color get bgVariant => isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant;
  Color get onSurfaceColor => isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
  Color get onSurfaceSubtitle => isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
  Color get dividerColor => isDark ? AppColors.darkDivider : AppColors.divider;
  Color get fpvBadgeColor => isDark ? AppColors.darkFpvBadge : AppColors.fpvBadge;
  Color get ficBadgeColor => isDark ? AppColors.darkFicBadge : AppColors.ficBadge;
  Color get subscribeColor => isDark ? AppColors.darkSubscribeAmount : AppColors.subscribeAmount;
  Color get cancelColor => isDark ? AppColors.darkCancelAmount : AppColors.cancelAmount;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? (isDark ? AppColors.darkError : AppColors.error) : (isDark ? AppColors.darkSuccess : AppColors.success),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
