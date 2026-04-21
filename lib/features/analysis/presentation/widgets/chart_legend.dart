import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/legend_dot.dart';
import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({required this.category, super.key});

  final AnalysisCategory category;

  @override
  Widget build(BuildContext context) {
    final items = category.isBloodPressure ? _bpItems : _sugarItems;

    return Wrap(
      spacing: 12,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: items.map((e) => LegendDot(color: e.$1, label: e.$2)).toList(),
    );
  }

  static const _bpItems = [
    (AppColors.bpHypotension, AppTexts.stageLow),
    (AppColors.bpNormal, AppTexts.stageNormal),
    (AppColors.bpElevated, AppTexts.stageElevated),
    (AppColors.bpStage1, AppTexts.stageStage1),
    (AppColors.bpStage2, AppTexts.stageStage2),
    (AppColors.bpCrisis, AppTexts.stageCrisis),
  ];

  static const _sugarItems = [
    (AppColors.sugarHypo, AppTexts.stageHypo),
    (AppColors.sugarNormal, AppTexts.stageNormal),
    (AppColors.sugarPrediabet, AppTexts.stagePrediabet),
    (AppColors.sugarDiabet, AppTexts.stageDiabet),
  ];
}
