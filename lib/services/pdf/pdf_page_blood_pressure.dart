// PDF raporunun 2. sayfası: tansiyon trend grafikleri
// ve ölçüm detay tablosu.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_texts.dart';
import '../../core/enums/blood_pressure_stage.dart';
import '../../core/threshold_engine/threshold_engine.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import 'pdf_chart_painter.dart';
import 'pdf_font_loader.dart';
import 'pdf_table_builder.dart';
import 'pdf_theme.dart';
import 'pdf_widgets.dart';

class PdfPageBloodPressure {
  PdfPageBloodPressure._();

  static pw.Widget _stageLegendItem(String label, PdfColor color) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Container(
          width: 8,
          height: 8,
          decoration: pw.BoxDecoration(
            color: color,
            shape: pw.BoxShape.circle,
          ),
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
        pw.Container(
          width: 14,
          height: 2,
          color: color,
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

  static pw.Page build(
    List<Measurement> bpList,
    int age,
    String gender,
    ThresholdEngine engine,
  ) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(22),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfWidgets.header(AppTexts.pdfBPReport, null),
          pw.SizedBox(height: 10),
          PdfWidgets.sectionTitle(AppTexts.pdfBPTrendCombined),
          pw.SizedBox(height: 4),
          PdfChartPainter.dualLineChart(
            measurements: bpList,
            getPrimaryValue: (m) => m.value1,
            getSecondaryValue: (m) => m.value2 ?? 0,
            getPointColor: (m) {
              final stage = engine.evaluateBPStage(
                systolic: m.value1.toInt(),
                diastolic: (m.value2 ?? 0).toInt(),
                age: age,
                gender: gender,
              );
              return PdfTheme.stageColor(stage.label);
            },
            unit: 'mmHg',
            height: 130,
          ),
          pw.SizedBox(height: 8),
          pw.Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              _lineLegendItem(AppTexts.pdfSystolicLine, PdfTheme.primaryDark),
              _lineLegendItem(AppTexts.pdfDiastolicLine, PdfTheme.accent),
            ],
          ),
          pw.SizedBox(height: 6),
          PdfWidgets.sectionTitle(AppTexts.pdfLegendTitle),
          pw.SizedBox(height: 4),
          pw.Wrap(
            spacing: 10,
            runSpacing: 4,
            children: BloodPressureStage.values
                .map((s) => _stageLegendItem(s.label, PdfTheme.stageColor(s.label)))
                .toList(),
          ),
          pw.SizedBox(height: 8),
          PdfWidgets.sectionTitle(AppTexts.pdfMeasurementDetails),
          pw.SizedBox(height: 4),
          PdfTableBuilder.bloodPressure(bpList, age, gender, engine),
          pw.Spacer(),
          PdfWidgets.footer(2, 3),
        ],
      ),
    );
  }
}
