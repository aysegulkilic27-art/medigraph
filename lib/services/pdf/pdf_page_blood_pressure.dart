// PDF raporunun 2. sayfası: tansiyon trend grafikleri
// ve ölçüm detay tablosu.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_texts.dart';
import '../../core/enums/blood_pressure_stage.dart';
import '../../core/threshold_engine/threshold_engine.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import 'pdf_chart_painter.dart';
import 'pdf_table_builder.dart';
import 'pdf_theme.dart';
import 'pdf_widgets.dart';

class PdfPageBloodPressure {
  PdfPageBloodPressure._();

  static pw.Page build(
    List<Measurement> bpList,
    int age,
    ThresholdEngine engine,
  ) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfWidgets.header(AppTexts.pdfBPReport, null),
          pw.SizedBox(height: 10),
          PdfWidgets.sectionTitle(AppTexts.pdfSystolicTrend),
          pw.SizedBox(height: 4),
          PdfChartPainter.lineChart(
            measurements: bpList,
            getValue: (m) => m.value1,
            getColor: (m) {
              final stage = engine.evaluateBPStage(
                systolic: m.value1.toInt(),
                diastolic: (m.value2 ?? 0).toInt(),
                age: age,
              );
              return PdfTheme.stageColor(stage.label);
            },
            unit: 'mmHg',
            height: 70,
          ),
          pw.SizedBox(height: 8),
          PdfWidgets.sectionTitle(AppTexts.pdfDiastolicTrend),
          pw.SizedBox(height: 4),
          PdfChartPainter.lineChart(
            measurements: bpList,
            getValue: (m) => m.value2 ?? 0,
            getColor: (m) {
              final stage = engine.evaluateBPStage(
                systolic: m.value1.toInt(),
                diastolic: (m.value2 ?? 0).toInt(),
                age: age,
              );
              return PdfTheme.stageColor(stage.label);
            },
            unit: 'mmHg',
            height: 70,
          ),
          pw.SizedBox(height: 8),
          PdfWidgets.sectionTitle(AppTexts.pdfMeasurementDetails),
          pw.SizedBox(height: 4),
          PdfTableBuilder.bloodPressure(bpList, age, engine),
          pw.Spacer(),
          PdfWidgets.footer(2, 3),
        ],
      ),
    );
  }
}
