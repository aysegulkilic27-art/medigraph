// PDF sağlık raporu oluşturma ve paylaşma servisinin
// ana orkestratörü. Seçilen tarih aralığındaki verileri
// 3 sayfalık rapora dönüştürür.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_texts.dart';
import '../../core/enums/measurement_type.dart';
import '../../core/threshold_engine/threshold_engine.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import '../../features/profile/domain/entities/user_profile.dart';
import 'pdf_font_loader.dart';
import 'pdf_page_blood_pressure.dart';
import 'pdf_page_blood_sugar.dart';
import 'pdf_page_summary.dart';
import 'pdf_table_builder.dart';
import 'pdf_widgets.dart';

class PdfReportService {
  PdfReportService._();

  static Future<void> generateAndShare({
    required BuildContext context,
    required List<Measurement> allMeasurements,
    required UserProfile? profile,
    required DateTimeRange dateRange,
    bool aggregateWeekly = false,
  }) async {
    await PdfFontLoader.load();

    final now = DateTime.now();
    final rangeStart = DateTime(
      dateRange.start.year,
      dateRange.start.month,
      dateRange.start.day,
    );
    final rangeEndExclusive = DateTime(
      dateRange.end.year,
      dateRange.end.month,
      dateRange.end.day,
    ).add(const Duration(days: 1));

    final filtered =
        allMeasurements
            .where(
              (m) =>
                  !m.dateTime.isBefore(rangeStart) &&
                  m.dateTime.isBefore(rangeEndExclusive),
            )
            .toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final bpMeasurements = filtered
        .where((m) => m.type == MeasurementType.bloodPressure)
        .toList();
    final sugarMeasurements = filtered
        .where((m) => m.type == MeasurementType.bloodSugar)
        .toList();

    final age = profile?.age ?? 30;
    final gender = profile?.gender ?? 'male';
    final engine = ThresholdEngine.instance;

    final bpDetailChunks = aggregateWeekly
        ? _chunkBySize(
            [...bpMeasurements]
              ..sort((a, b) => b.dateTime.compareTo(a.dateTime)),
            30,
          )
        : <List<Measurement>>[];
    final sugarDetailChunks = aggregateWeekly
        ? _chunkBySize(
            [...sugarMeasurements]
              ..sort((a, b) => b.dateTime.compareTo(a.dateTime)),
            30,
          )
        : <List<Measurement>>[];

    final totalPages =
        3 +
        (aggregateWeekly
            ? bpDetailChunks.length + sugarDetailChunks.length
            : 0);

    final pdf = pw.Document(theme: PdfFontLoader.theme);
    var pageNumber = 1;

    pdf.addPage(
      PdfPageSummary.build(
        profile: profile,
        bpList: bpMeasurements,
        sugarList: sugarMeasurements,
        age: age,
        gender: gender,
        engine: engine,
        now: now,
        dateRange: dateRange,
        pageNumber: pageNumber,
        totalPages: totalPages,
      ),
    );
    pageNumber++;

    pdf.addPage(
      PdfPageBloodPressure.build(
        bpMeasurements,
        age,
        gender,
        engine,
        pageNumber: pageNumber,
        totalPages: totalPages,
        aggregateWeekly: aggregateWeekly,
        includeDetailsTable: !aggregateWeekly,
      ),
    );
    pageNumber++;

    pdf.addPage(
      PdfPageBloodSugar.build(
        sugarMeasurements,
        age,
        engine,
        pageNumber: pageNumber,
        totalPages: totalPages,
        aggregateWeekly: aggregateWeekly,
        includeDetailsTable: !aggregateWeekly,
      ),
    );
    pageNumber++;

    if (aggregateWeekly) {
      for (var i = 0; i < bpDetailChunks.length; i++) {
        final chunk = bpDetailChunks[i];
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4.landscape,
            margin: const pw.EdgeInsets.all(22),
            build: (_) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfWidgets.header(
                  '${AppTexts.pdfBPReport} - Detay ${i + 1}',
                  null,
                ),
                pw.SizedBox(height: 10),
                PdfWidgets.sectionTitle(AppTexts.pdfMeasurementDetails),
                pw.SizedBox(height: 4),
                PdfTableBuilder.bloodPressure(
                  chunk,
                  age,
                  gender,
                  engine,
                  maxRows: null,
                  newestFirst: false,
                  showTruncationHint: false,
                ),
                pw.Spacer(),
                PdfWidgets.footer(pageNumber, totalPages),
              ],
            ),
          ),
        );
        pageNumber++;
      }

      for (var i = 0; i < sugarDetailChunks.length; i++) {
        final chunk = sugarDetailChunks[i];
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4.landscape,
            margin: const pw.EdgeInsets.all(22),
            build: (_) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfWidgets.header(
                  '${AppTexts.pdfSugarReport} - Detay ${i + 1}',
                  null,
                ),
                pw.SizedBox(height: 10),
                PdfWidgets.sectionTitle(AppTexts.pdfMeasurementDetails),
                pw.SizedBox(height: 4),
                PdfTableBuilder.bloodSugar(
                  chunk,
                  age,
                  engine,
                  maxRows: null,
                  newestFirst: false,
                  showTruncationHint: false,
                ),
                pw.Spacer(),
                PdfWidgets.footer(pageNumber, totalPages),
              ],
            ),
          ),
        );
        pageNumber++;
      }
    }

    final fileName =
        '${AppTexts.pdfFileName}${DateFormat(AppConstants.dateTimeFormatFileName).format(now)}.pdf';
    final bytes = await pdf.save();

    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }

  static List<List<Measurement>> _chunkBySize(
    List<Measurement> list,
    int size,
  ) {
    if (list.isEmpty) return const [];
    final chunks = <List<Measurement>>[];
    for (var i = 0; i < list.length; i += size) {
      final end = (i + size) > list.length ? list.length : i + size;
      chunks.add(list.sublist(i, end));
    }
    return chunks;
  }
}
