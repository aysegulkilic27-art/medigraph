// Rapor dönemi seçeneğini temsil eden model sınıfı ve
// hazır seçenekler listesi.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class ReportPeriodOption {
  final String label;
  final IconData icon;
  final int? days;

  const ReportPeriodOption(this.label, this.icon, this.days);
}

const reportPeriodOptions = [
  ReportPeriodOption(AppTexts.periodWeek, Icons.calendar_view_week, 7),
  ReportPeriodOption(AppTexts.periodMonth, Icons.calendar_month, 30),
  ReportPeriodOption(AppTexts.periodThreeMonths, Icons.date_range, 90),
  ReportPeriodOption(AppTexts.periodCustom, Icons.tune, null),
];
