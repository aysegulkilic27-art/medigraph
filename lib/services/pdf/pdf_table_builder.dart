// Tansiyon ve şeker ölçümlerini PDF tablosuna dönüştüren builder.
// Stage renkli badge ve maksimum 30 kayıt gösterimi içerir.

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_texts.dart';
import '../../core/enums/blood_pressure_stage.dart';
import '../../core/enums/blood_sugar_stage.dart';
import '../../core/threshold_engine/threshold_engine.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import 'pdf_font_loader.dart';
import 'pdf_theme.dart';

class PdfTableBuilder {
  PdfTableBuilder._();

  static pw.Widget bloodPressure(
    List<Measurement> list,
    int age,
    ThresholdEngine engine,
  ) {
    final headers = ['Tarih', 'Büyük', 'Küçük', 'Durum', 'Not'];
    final rows = list.reversed.take(30).map((m) {
      final stage = engine.evaluateBPStage(
        systolic: m.value1.toInt(),
        diastolic: (m.value2 ?? 0).toInt(),
        age: age,
      );
      final note = (m.note ?? '').trim();
      return [
        DateFormat(AppConstants.dateTimeFormat).format(m.dateTime),
        '${m.value1.toInt()} mmHg',
        '${(m.value2 ?? 0).toInt()} mmHg',
        stage.label,
        note.isEmpty ? '-' : note,
      ];
    }).toList();

    return _table(headers, rows, list.length);
  }

  static pw.Widget bloodSugar(
    List<Measurement> list,
    int age,
    ThresholdEngine engine,
  ) {
    final headers = ['Tarih', 'Deger', 'Tur', 'Durum', 'Not'];
    final rows = list.reversed.take(30).map((m) {
      final stage = engine.evaluateSugarStage(
        value: m.value1,
        isFasting: m.isFasting ?? true,
      );
      final note = (m.note ?? '').trim();
      return [
        DateFormat(AppConstants.dateTimeFormat).format(m.dateTime),
        '${m.value1.toStringAsFixed(0)} mg/dL',
        m.isFasting == true ? 'Açlık' : 'Tokluk',
        stage.label,
        note.isEmpty ? '-' : note,
      ];
    }).toList();

    return _table(headers, rows, list.length);
  }

  static pw.Widget _table(
    List<String> headers,
    List<List<String>> rows,
    int totalCount,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (totalCount > 30)
          pw.Text(
            '${AppTexts.pdfShowingLast} $totalCount)',
            style: PdfFontLoader.textStyle(
              color: PdfTheme.textSecond,
              fontSize: 7,
            ),
          ),
        if (rows.isEmpty)
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfTheme.bgLight,
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              AppTexts.pdfNoRecords,
              style: PdfFontLoader.textStyle(
                color: PdfTheme.textSecond,
                fontSize: 8,
              ),
            ),
          )
        else
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2.1),
              1: const pw.FlexColumnWidth(1.3),
              2: const pw.FlexColumnWidth(1.1),
              3: const pw.FlexColumnWidth(1.1),
              4: const pw.FlexColumnWidth(2.4),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfTheme.primary),
                children: headers
                    .map(
                      (h) => pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          h,
                          style: PdfFontLoader.textStyle(
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 7,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...rows.asMap().entries.map((entry) {
                final i = entry.key;
                final row = entry.value;
                final stageLabel = row[3];
                final stageColor = PdfTheme.stageColor(stageLabel);
                return pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: i.isEven ? PdfTheme.surface : PdfTheme.bgLight,
                  ),
                  children: row.asMap().entries.map((cell) {
                    final isStage = cell.key == 3;
                    return pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 2,
                      ),
                      child: isStage
                          ? pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 1,
                              ),
                              decoration: pw.BoxDecoration(
                                color: PdfColor(
                                  stageColor.red,
                                  stageColor.green,
                                  stageColor.blue,
                                  0.15,
                                ),
                                borderRadius: pw.BorderRadius.circular(3),
                              ),
                              child: pw.Text(
                                cell.value,
                                style: PdfFontLoader.textStyle(
                                  color: stageColor,
                                  fontSize: 6,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            )
                          : pw.Text(
                              cell.value,
                              style: PdfFontLoader.textStyle(
                                color: PdfTheme.textPrimary,
                                fontSize: 6,
                              ),
                            ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
      ],
    );
  }
}
