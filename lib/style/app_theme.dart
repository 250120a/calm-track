import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );
    return _baseTheme(colorScheme, Brightness.light);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    );
    return _baseTheme(colorScheme, Brightness.dark);
  }

  static ThemeData _baseTheme(ColorScheme colorScheme, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scaffold = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final baseTextTheme = ThemeData(brightness: brightness).textTheme;
    final textTheme = baseTextTheme.apply(
      bodyColor: isDark ? Colors.white : AppColors.textPrimary,
      displayColor: isDark ? Colors.white : AppColors.textPrimary,
      fontFamily: 'Manrope',
    );
    final dividerColor = Colors.white.withValues(alpha: isDark ? 0.12 : 0.2);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffold,
      fontFamily: 'Manrope',
      textTheme: _customizeTextTheme(textTheme),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        backgroundColor: scaffold,
        foregroundColor: isDark ? Colors.white : AppColors.textPrimary,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark.copyWith(statusBarColor: scaffold, statusBarBrightness: Brightness.light),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? Colors.white.withValues(alpha: 0.85) : AppColors.primary,
        contentTextStyle: TextStyle(color: isDark ? Colors.black87 : Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withValues(alpha: isDark ? 0.08 : 0.6),
        elevation: 0,
        selectedItemColor: isDark ? Colors.white : AppColors.primary,
        unselectedItemColor: (isDark ? Colors.white : AppColors.textSecondary).withValues(alpha: 0.7),
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      cardColor: Colors.transparent,
      dividerColor: dividerColor,
      elevatedButtonTheme: ElevatedButtonThemeData(style: _glassButtonStyle(brightness)),
      filledButtonTheme: FilledButtonThemeData(style: _glassButtonStyle(brightness)),
      outlinedButtonTheme: OutlinedButtonThemeData(style: _glassOutlinedButtonStyle(brightness)),
      textButtonTheme: TextButtonThemeData(style: _glassTextButtonStyle(brightness)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: isDark ? 0.08 : 0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: isDark ? Colors.white70 : AppColors.primary, width: 1.4),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  static ButtonStyle _glassButtonStyle(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    Color resolveBackground(Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.white.withValues(alpha: isDark ? 0.05 : 0.25);
      }
      if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return Colors.white.withValues(alpha: isDark ? 0.24 : 0.78);
      }
      return Colors.white.withValues(alpha: isDark ? 0.16 : 0.62);
    }

    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStateProperty.resolveWith(resolveBackground),
      foregroundColor: WidgetStatePropertyAll(isDark ? Colors.white : AppColors.textPrimary),
      overlayColor: WidgetStatePropertyAll(Colors.white.withValues(alpha: isDark ? 0.08 : 0.25)),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 22)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    );
  }

  static ButtonStyle _glassOutlinedButtonStyle(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = _glassButtonStyle(brightness);
    return base.copyWith(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      side: WidgetStateProperty.resolveWith(
        (states) {
          final opacity = states.contains(WidgetState.disabled) ? (isDark ? 0.06 : 0.2) : (isDark ? 0.26 : 0.45);
          return BorderSide(color: Colors.white.withValues(alpha: opacity), width: 1.2);
        },
      ),
      foregroundColor: WidgetStatePropertyAll(isDark ? Colors.white : AppColors.textPrimary),
    );
  }

  static ButtonStyle _glassTextButtonStyle(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(isDark ? Colors.white : AppColors.primary),
      overlayColor: WidgetStatePropertyAll(Colors.white.withValues(alpha: isDark ? 0.1 : 0.25)),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
      textStyle: WidgetStatePropertyAll(
        const TextStyle(fontWeight: FontWeight.w600),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static TextTheme _customizeTextTheme(TextTheme textTheme) {
    return textTheme.copyWith(
      headlineLarge: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
      headlineMedium: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
      headlineSmall: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
      bodyLarge: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400, height: 1.5),
      bodyMedium: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, height: 1.5),
      bodySmall: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, height: 1.5),
      labelLarge: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      labelMedium: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      labelSmall: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
