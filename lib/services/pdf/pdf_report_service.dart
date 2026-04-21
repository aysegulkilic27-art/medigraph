// PDF sağlık raporu oluşturma ve paylaşma servisinin
// ana orkestratörü. Seçilen tarih aralığındaki verileri
// 3 sayfalık rapora dönüştürür.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

class PdfReportService {
  PdfReportService._();

  static Future<void> generateAndShare({
    required BuildContext context,
    required List<Measurement> allMeasurements,
    required UserProfile? profile,
    required DateTimeRange dateRange,
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
    final engine = ThresholdEngine.instance;

    final pdf = pw.Document(theme: PdfFontLoader.theme);

    pdf.addPage(
      PdfPageSummary.build(
        profile: profile,
        bpList: bpMeasurements,
        sugarList: sugarMeasurements,
        age: age,
        engine: engine,
        now: now,
        dateRange: dateRange,
      ),
    );

    pdf.addPage(PdfPageBloodPressure.build(bpMeasurements, age, engine));
    pdf.addPage(PdfPageBloodSugar.build(sugarMeasurements, age, engine));

    final fileName =
        '${AppTexts.pdfFileName}${DateFormat(AppConstants.dateFormatFileName).format(now)}.pdf';

    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }
}
