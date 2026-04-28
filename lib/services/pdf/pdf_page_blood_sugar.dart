// PDF raporunun 3. sayfası: şeker trend grafikleri
// ve ölçüm detay tablosu.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_texts.dart';
import '../../core/enums/blood_sugar_stage.dart';
import '../../core/threshold_engine/threshold_engine.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import 'pdf_chart_painter.dart';
import 'pdf_font_loader.dart';
import 'pdf_table_builder.dart';
import 'pdf_theme.dart';
import 'pdf_weekly_aggregate.dart';
import 'pdf_widgets.dart';

class PdfPageBloodSugar {
  PdfPageBloodSugar._();

  static pw.Widget _stageLegendItem(String label, PdfColor color) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Container(
          width: 8,
          height: 8,
          decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
        ),
        pw.SizedBox(width: 4),
        pw.Text(
          label,
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textPrimary,
            fontSize: 8,
          ),
        ),
      ],
    );
  }

  static pw.Widget _lineLegendItem(String label, PdfColor color) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Container(width: 14, height: 2, color: color),
        pw.SizedBox(width: 4),
        pw.Text(
          label,
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textPrimary,
            fontSize: 8,
          ),
        ),
      ],
    );
  }

  static pw.Page build(
    List<Measurement> sugarList,
    int age,
    ThresholdEngine engine, {
    required int pageNumber,
    required int totalPages,
    bool aggregateWeekly = false,
    bool includeDetailsTable = true,
  }) {
    final fastingList = sugarList.where((m) => m.isFasting == true).toList();
    final postMealList = sugarList.where((m) => m.isFasting != true).toList();
    final fastingWeekly = aggregateWeekly
        ? weeklySugarAggregates(fastingList)
        : const <WeeklyTriple>[];
    final postWeekly = aggregateWeekly
        ? weeklySugarAggregates(postMealList)
        : const <WeeklyTriple>[];

    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(22),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfWidgets.header(AppTexts.pdfSugarReport, null),
          pw.SizedBox(height: 10),
          if (fastingList.isEmpty && postMealList.isEmpty)
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfTheme.bgLight,
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Text(
                AppTexts.pdfNoSugar,
                style: PdfFontLoader.textStyle(
                  color: PdfTheme.textSecond,
                  fontSize: 9,
                ),
              ),
            ),
          if (fastingList.isNotEmpty || postMealList.isNotEmpty) ...[
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      PdfWidgets.sectionTitle(AppTexts.pdfFastingTrend),
                      pw.SizedBox(height: 4),
                      if (!aggregateWeekly)
                        PdfChartPainter.lineChart(
                          measurements: fastingList,
                          getValue: (m) => m.value1,
                          getColor: (m) {
                            final stage = engine.evaluateSugarStage(
                              value: m.value1,
                              isFasting: true,
                            );
                            return PdfTheme.stageColor(stage.label);
                          },
                          unit: 'mg/dL',
                          height: 110,
                        )
                      else
                        PdfChartPainter.weeklyMinAvgMaxChart(
                          points: fastingWeekly,
                          unit: 'mg/dL',
                          height: 110,
                        ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 10),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      PdfWidgets.sectionTitle(AppTexts.pdfPostMealTrend),
                      pw.SizedBox(height: 4),
                      if (!aggregateWeekly)
                        PdfChartPainter.lineChart(
                          measurements: postMealList,
                          getValue: (m) => m.value1,
                          getColor: (m) {
                            final stage = engine.evaluateSugarStage(
                              value: m.value1,
                              isFasting: false,
                            );
                            return PdfTheme.stageColor(stage.label);
                          },
                          unit: 'mg/dL',
                          height: 110,
                        )
                      else
                        PdfChartPainter.weeklyMinAvgMaxChart(
                          points: postWeekly,
                          unit: 'mg/dL',
                          height: 110,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                if (!aggregateWeekly) ...[
                  _lineLegendItem(AppTexts.fasting, PdfTheme.primaryDark),
                  _lineLegendItem(AppTexts.postMeal, PdfTheme.accent),
                ] else ...[
                  _lineLegendItem('Minimum', PdfTheme.primary),
                  _lineLegendItem('Ortalama', PdfTheme.primaryDark),
                  _lineLegendItem('Maksimum', PdfTheme.accent),
                ],
              ],
            ),
            pw.SizedBox(height: 6),
            PdfWidgets.sectionTitle(AppTexts.pdfLegendTitle),
            pw.SizedBox(height: 4),
            pw.Wrap(
              spacing: 10,
              runSpacing: 4,
              children: BloodSugarStage.values
                  .map(
                    (s) =>
                        _stageLegendItem(s.label, PdfTheme.stageColor(s.label)),
                  )
                  .toList(),
            ),
          ],
          if (includeDetailsTable) ...[
            pw.SizedBox(height: 8),
            PdfWidgets.sectionTitle(AppTexts.pdfMeasurementDetails),
            pw.SizedBox(height: 4),
            PdfTableBuilder.bloodSugar(sugarList, age, engine),
          ],
          pw.Spacer(),
          PdfWidgets.footer(pageNumber, totalPages),
        ],
      ),
    );
  }
}
