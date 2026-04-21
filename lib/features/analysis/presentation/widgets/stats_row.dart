// Üç istatistik kartını yan yana gösteren satır widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/features/analysis/domain/models/category_stats.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.stats,
    required this.selectedCategory,
  });

  final CategoryStats stats;
  final AnalysisCategory selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(
          label: AppTexts.statTotal,
          value: '${stats.total}',
          icon: Icons.list_alt_rounded,
          gradient: const [AppColors.statTotalStart, AppColors.statTotalEnd],
        ),
        SizedBox(width: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2),
        StatCard(
          label: AppTexts.statExceeded,
          value: '${stats.exceeded}',
          icon: Icons.warning_amber_rounded,
          gradient: stats.exceeded > 0
              ? const [AppColors.statExceededStart, AppColors.statExceededEnd]
              : const [AppColors.statTotalStart, AppColors.statTotalEnd],
        ),
        SizedBox(width: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2),
        StatCard(
          label: AppTexts.statAverage,
          value: stats.average != null ? stats.average!.toStringAsFixed(1) : '-',
          unit: selectedCategory.unit,
          icon: Icons.analytics_outlined,
          gradient: const [AppColors.statAvgStart, AppColors.statAvgEnd],
        ),
      ],
    );
  }
}
