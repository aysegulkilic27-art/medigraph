// Ölçüm verilerini stage renkli sütun grafik olarak gösteren kart.
// Her sütun rengi klinik evreye karşılık gelir.

import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/chart_legend.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChartCard extends StatelessWidget {
  const BarChartCard({
    super.key,
    required this.measurements,
    required this.category,
    required this.age,
    required this.gender,
  });

  final List<Measurement> measurements;
  final AnalysisCategory category;
  final int age;
  final String gender;

  @override
  Widget build(BuildContext context) {
    final barGroups = measurements.asMap().entries.map((entry) {
      final i = entry.key;
      final m = entry.value;
      final value = category == AnalysisCategory.diastolic
          ? (m.value2 ?? 0)
          : m.value1;
      final barColor = StageColorResolver.fromMeasurement(
        m,
        age,
        gender: gender,
      );

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: value,
            color: barColor,
            width: measurements.length > 20 ? 6 : 14,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
            ),
          ),
        ],
      );
    }).toList();

    return Container(
      height: AppDimensions.chartHeight(context),
      padding: EdgeInsets.all(AppDimensions.cardPadding(context)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                category.isBloodPressure ? Icons.favorite : Icons.water_drop,
                color: AppColors.primary,
                size: AppDimensions.iconSM(context),
              ),
              SizedBox(width: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
              Text(
                '${category.label} (${category.unit})',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimensions.fontSM(context) + AppDimensions.spacingXS(context) / 4,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingSM(context)),
          Expanded(
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: AppColors.textHint.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (val, meta) => Text(
                        val.toInt().toString(),
                        style: GoogleFonts.spaceMono(
                          fontSize: AppDimensions.fontXS(context) - AppDimensions.spacingXS(context) / 4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      getTitlesWidget: (val, meta) {
                        final idx = val.toInt();
                        if (idx >= measurements.length || idx.isOdd) {
                          return const SizedBox();
                        }
                        final dt = measurements[idx].dateTime;
                        return Text(
                          '${dt.day}/${dt.month}',
                          style: GoogleFonts.nunito(
                            fontSize: AppDimensions.fontXS(context) - AppDimensions.spacingXS(context) / 4,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(0)} ${category.unit}',
                        GoogleFonts.spaceMono(
                          color: Colors.white,
                          fontSize: AppDimensions.fontXS(context) + AppDimensions.spacingXS(context) / 4,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
          ChartLegend(category: category),
        ],
      ),
    );
  }
}
