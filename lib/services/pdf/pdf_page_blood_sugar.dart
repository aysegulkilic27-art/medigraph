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
import 'pdf_widgets.dart';

class PdfPageBloodSugar {
  PdfPageBloodSugar._();

  static pw.Page build(
    List<Measurement> sugarList,
    int age,
    ThresholdEngine engine,
  ) {
    final fastingList = sugarList.where((m) => m.isFasting == true).toList();
    final postMealList = sugarList.where((m) => m.isFasting != true).toList();

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfWidgets.header(AppTexts.pdfSugarReport, null),
          pw.SizedBox(height: 10),
          if (fastingList.isNotEmpty) ...[
            PdfWidgets.sectionTitle(AppTexts.pdfFastingTrend),
            pw.SizedBox(height: 4),
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
              height: 62,
            ),
            pw.SizedBox(height: 6),
          ],
          if (postMealList.isNotEmpty) ...[
            PdfWidgets.sectionTitle(AppTexts.pdfPostMealTrend),
            pw.SizedBox(height: 4),
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
              height: 62,
            ),
            pw.SizedBox(height: 6),
          ],
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
          PdfWidgets.sectionTitle(AppTexts.pdfMeasurementDetails),
          pw.SizedBox(height: 4),
          PdfTableBuilder.bloodSugar(sugarList, age, engine),
          pw.Spacer(),
          PdfWidgets.footer(3, 3),
        ],
      ),
    );
  }
}
