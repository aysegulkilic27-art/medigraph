// Renk paleti (AppColors) ve Flutter tema yapılandırması.
// Tüm UI renkleri buradan okunur.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF00897B);
  static const primaryDark = Color(0xFF00695C);
  static const accent = Color(0xFFFF7043);
  static const accentDark = Color(0xFFE64A19);
  static const accentBlue = Color(0xFF29B6F6);

  static const background = Color(0xFFF0FAF9);
  static const surface = Color(0xFFFFFFFF);
  static const cardBg = Color(0xFFFFFFFF);

  static const textPrimary = Color(0xFF1A2E2C);
  static const textSecondary = Color(0xFF546E7A);
  static const textHint = Color(0xFF90A4AE);

  static const statusNormal = Color(0xFF26A69A);
  static const statusHigh = Color(0xFFEF5350);

  static const bpHypotension = Color(0xFF42A5F5);
  static const bpNormal = Color(0xFF26A69A);
  static const bpElevated = Color(0xFFFFB300);
  static const bpStage1 = Color(0xFFFF7043);
  static const bpStage2 = Color(0xFFEF5350);
  static const bpCrisis = Color(0xFF7B0000);

  static const sugarHypo = Color(0xFF42A5F5);
  static const sugarNormal = Color(0xFF26A69A);
  static const sugarPrediabet = Color(0xFFFF7043);
  static const sugarDiabet = Color(0xFFEF5350);

  static const pressureGradientStart = Color(0xFF00897B);
  static const pressureGradientEnd = Color(0xFF26A69A);
  static const sugarGradientStart = Color(0xFF0277BD);
  static const sugarGradientEnd = Color(0xFF29B6F6);
  static const inputFill = Color(0xFFE8F5F3);
  static const bannerStart = Color(0xFFFFF8E1);
  static const bannerEnd = Color(0xFFFFF3CD);
  static const bannerBorder = Color(0xFFFFCC02);
  static const bannerText = Color(0xFF5D4037);
  static const bannerIcon = Color(0xFFF57F17);

  static const statTotalStart = primary;
  static const statTotalEnd = primaryDark;
  static const statExceededStart = accent;
  static const statExceededEnd = accentDark;
  static const statAvgStart = accentBlue;
  static const statAvgEnd = Color(0xFF0277BD);

  static const chipBPStart = primary;
  static const chipBPEnd = primaryDark;
  static const chipSugarStart = accentBlue;
  static const chipSugarEnd = Color(0xFF0277BD);

  static const divider = Color(0xFFCCCCCC);
  static const shadowColor = Color(0xFF000000);
}

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).copyWith(
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: GoogleFonts.nunito(color: AppColors.textSecondary),
        hintStyle: GoogleFonts.nunito(color: AppColors.textHint),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

