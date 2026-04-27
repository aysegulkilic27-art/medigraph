// Analiz ekranının filtre, istatistik ve grafik bölümlerini
// bir araya getiren ana içerik widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/features/analysis/domain/models/category_stats.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/bar_chart_card.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/category_selector.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/empty_state.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/line_chart_card.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/stats_row.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalysisScreenContent extends StatelessWidget {
  const AnalysisScreenContent({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.statsAsync,
    required this.measurementsAsync,
    required this.barGroupsAsync,
    required this.age,
    required this.gender,
  });

  final AnalysisCategory selectedCategory;
  final ValueChanged<AnalysisCategory> onCategoryChanged;
  final AsyncValue<CategoryStats> statsAsync;
  final AsyncValue<List<Measurement>> measurementsAsync;
  final AsyncValue<List<BarChartGroupData>> barGroupsAsync;
  final int age;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategorySelector(selected: selectedCategory, onChanged: onCategoryChanged),
        SizedBox(height: AppDimensions.spacingMD(context)),
        statsAsync.when(
          data: (stats) => StatsRow(
            stats: stats,
            selectedCategory: selectedCategory,
          ),
          loading: () => Center(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.cardPadding(context)),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
          error: (e, _) => Text('${AppTexts.errorPrefix}: $e'),
        ),
        SizedBox(height: AppDimensions.spacingMD(context)),
        measurementsAsync.when(
          data: (measurements) {
            if (measurements.isEmpty) {
              return AnalysisEmptyState(category: selectedCategory);
            }
            return barGroupsAsync.when(
              data: (_) => Column(
                children: [
                  BarChartCard(
                    measurements: measurements,
                    category: selectedCategory,
                    age: age,
                    gender: gender,
                  ),
                  SizedBox(height: AppDimensions.spacingMD(context)),
                  LineChartCard(
                    measurements: measurements,
                    category: selectedCategory,
                    age: age,
                    gender: gender,
                  ),
                ],
              ),
              loading: () => _loadingCard(context),
              error: (e, _) => Text('${AppTexts.errorPrefix}: $e'),
            );
          },
          loading: () => _loadingCard(context),
          error: (e, _) => Text('${AppTexts.errorPrefix}: $e'),
        ),
      ],
    );
  }

  Widget _loadingCard(BuildContext context) {
    return Container(
      height: AppDimensions.chartHeight(context),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
