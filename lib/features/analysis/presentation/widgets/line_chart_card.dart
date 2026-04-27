// Ölçüm trend'ini çizgi grafik olarak gösteren kart.
// Zaman içindeki değişimi görselleştirir.

import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineChartCard extends StatelessWidget {
  const LineChartCard({
    required this.measurements,
    required this.category,
    required this.age,
    required this.gender,
    super.key,
  });

  final List<Measurement> measurements;
  final AnalysisCategory category;
  final int age;
  final String gender;

  @override
  Widget build(BuildContext context) {
    if (measurements.isEmpty) return const SizedBox.shrink();

    final spots = measurements.asMap().entries.map((entry) {
      final i = entry.key;
      final m = entry.value;
      final value = category == AnalysisCategory.diastolic
          ? (m.value2 ?? 0)
          : m.value1;
      return FlSpot(i.toDouble(), value);
    }).toList();

    final values = spots.map((s) => s.y).toList();
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final minY = (minValue - 10).clamp(0, double.maxFinite).toDouble();
    final maxY = maxValue + 10;

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
                category.isBloodPressure ? Icons.show_chart : Icons.trending_up,
                color: AppColors.primary,
                size: AppDimensions.iconSM(context),
              ),
              SizedBox(width: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
              Text(
                'Trend - ${category.label} (${category.unit})',
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
            child: LineChart(
              LineChartData(
                minY: minY,
                maxY: maxY,
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
                      getTitlesWidget: (val, _) => Text(
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
                      getTitlesWidget: (val, _) {
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
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: AppColors.primary,
                    barWidth: 2.5,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, idx) {
                        final m = measurements[idx];
                        final dotColor = StageColorResolver.fromMeasurement(
                          m,
                          age,
                          gender: gender,
                        );
                        return FlDotCirclePainter(
                          radius: 4,
                          color: dotColor,
                          strokeWidth: 1.5,
                          strokeColor: AppColors.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(0)} ${category.unit}',
                          GoogleFonts.spaceMono(
                            color: Colors.white,
                            fontSize: AppDimensions.fontXS(context) + AppDimensions.spacingXS(context) / 4,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
