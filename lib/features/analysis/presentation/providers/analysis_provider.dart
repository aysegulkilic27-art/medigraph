// Analiz ekranı için filtrelenmiş veri, istatistik ve grafik
// verilerini hesaplayan Riverpod provider'ları.

import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/core/enums/blood_sugar_stage.dart';
import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/core/models/date_range.dart';
import 'package:diyabetansiyon/core/threshold_engine/threshold_engine.dart';
import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/features/analysis/domain/models/category_stats.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/measurement/presentation/providers/measurement_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analysis_provider.g.dart';

DateRange _getDateRange(int tabIndex) {
  final now = DateTime.now();
  return switch (tabIndex) {
    0 => DateRange(start: DateTime(now.year, now.month, now.day), end: now),
    1 => DateRange(start: now.subtract(const Duration(days: 7)), end: now),
    2 => DateRange(start: now.subtract(const Duration(days: 30)), end: now),
    _ => DateRange(start: now.subtract(const Duration(days: 90)), end: now),
  };
}

List<Measurement> _filterByCategory(
  List<Measurement> allMeasurements,
  AnalysisCategory category,
) {
  return switch (category) {
    AnalysisCategory.systolic =>
      allMeasurements
          .where((m) => m.type == MeasurementType.bloodPressure)
          .toList(),
    AnalysisCategory.diastolic =>
      allMeasurements
          .where(
            (m) => m.type == MeasurementType.bloodPressure && m.value2 != null,
          )
          .toList(),
    AnalysisCategory.fasting =>
      allMeasurements
          .where(
            (m) => m.type == MeasurementType.bloodSugar && m.isFasting == true,
          )
          .toList(),
    AnalysisCategory.postMeal =>
      allMeasurements
          .where(
            (m) => m.type == MeasurementType.bloodSugar && m.isFasting == false,
          )
          .toList(),
  };
}

bool _isLowForCategory(
  Measurement measurement,
  AnalysisCategory category,
  ThresholdEngine engine,
) {
  return switch (category) {
    AnalysisCategory.systolic => measurement.value1 < 90,
    AnalysisCategory.diastolic => (measurement.value2 ?? 0) < 60,
    AnalysisCategory.fasting =>
      engine.evaluateSugarStage(value: measurement.value1, isFasting: true) ==
      BloodSugarStage.hypoglycemia,
    AnalysisCategory.postMeal =>
      engine.evaluateSugarStage(value: measurement.value1, isFasting: false) ==
      BloodSugarStage.hypoglycemia,
  };
}

CategoryStats _calculateStats(
  List<Measurement> allMeasurements,
  AnalysisCategory category,
  ThresholdEngine engine,
  int age,
) {
  final filtered = _filterByCategory(allMeasurements, category);
  if (filtered.isEmpty) return CategoryStats.empty;

  final values = filtered
      .map(
        (m) => category == AnalysisCategory.diastolic ? (m.value2 ?? 0) : m.value1,
      )
      .toList();

  return CategoryStats(
    total: filtered.length,
    exceeded: filtered
        .where((m) => StageColorResolver.isExceeded(m, age))
        .length,
    low: filtered.where((m) => _isLowForCategory(m, category, engine)).length,
    average: values.reduce((a, b) => a + b) / values.length,
  );
}

@riverpod
DateTimeRange selectedDateRange(
  SelectedDateRangeRef ref, {
  required int tabIndex,
}) {
  final range = _getDateRange(tabIndex);
  return DateTimeRange(start: range.start, end: range.end);
}

@riverpod
Future<List<Measurement>> filteredMeasurements(
  FilteredMeasurementsRef ref, {
  required AnalysisCategory category,
  required int tabIndex,
}) async {
  final activeProfile = ref.watch(activeProfileProvider);
  final range = ref.watch(selectedDateRangeProvider(tabIndex: tabIndex));
  final repo = ref.watch(measurementRepositoryProvider);
  final allInRange =
      await repo.getByDateRange(range.start, range.end, activeProfile?.id);
  final filtered = _filterByCategory(allInRange, category);
  filtered.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  return filtered;
}

@riverpod
Future<CategoryStats> categoryStats(
  CategoryStatsRef ref, {
  required AnalysisCategory category,
  required int tabIndex,
}) async {
  final activeProfile = ref.watch(activeProfileProvider);
  final range = ref.watch(selectedDateRangeProvider(tabIndex: tabIndex));
  final repo = ref.watch(measurementRepositoryProvider);
  final allInRange =
      await repo.getByDateRange(range.start, range.end, activeProfile?.id);
  final profile = await ref.watch(profileProvider.future);
  final age = profile?.age ?? 30;
  final engine = ThresholdEngine.instance;
  return _calculateStats(allInRange, category, engine, age);
}

@riverpod
Future<List<BarChartGroupData>> categoryBarGroups(
  CategoryBarGroupsRef ref, {
  required AnalysisCategory category,
  required int tabIndex,
}) async {
  final list = await ref.watch(
    filteredMeasurementsProvider(category: category, tabIndex: tabIndex).future,
  );
  final profile = await ref.watch(profileProvider.future);
  final age = profile?.age ?? 30;

  return list.asMap().entries.map((entry) {
    final i = entry.key;
    final m = entry.value;
    final value = category == AnalysisCategory.diastolic ? (m.value2 ?? 0) : m.value1;
    final color = StageColorResolver.fromMeasurement(m, age);

    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: list.length > 20 ? 6 : 14,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }).toList();
}
