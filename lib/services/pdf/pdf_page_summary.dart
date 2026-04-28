// PDF raporunun 1. sayfası: hasta bilgileri, rapor dönemi,
// özet istatistikler ve ortalama değerler.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_texts.dart';
import '../../core/enums/blood_pressure_stage.dart';
import '../../core/enums/blood_sugar_stage.dart';
import '../../core/threshold_engine/threshold_engine.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import '../../features/profile/domain/entities/user_profile.dart';
import 'pdf_font_loader.dart';
import 'pdf_theme.dart';
import 'pdf_widgets.dart';

class PdfPageSummary {
  PdfPageSummary._();

  static pw.Page build({
    required UserProfile? profile,
    required List<Measurement> bpList,
    required List<Measurement> sugarList,
    required int age,
    required String gender,
    required ThresholdEngine engine,
    required DateTime now,
    required DateTimeRange dateRange,
    required int pageNumber,
    required int totalPages,
  }) {
    final bpExceeded = bpList.where((m) {
      final stage = engine.evaluateBPStage(
        systolic: m.value1.toInt(),
        diastolic: (m.value2 ?? 0).toInt(),
        age: age,
        gender: gender,
      );
      return stage.index >= BloodPressureStage.elevated.index;
    }).length;

    final sugarExceeded = sugarList.where((m) {
      final stage = engine.evaluateSugarStage(
        value: m.value1,
        isFasting: m.isFasting ?? true,
      );
      return stage.index >= BloodSugarStage.prediabetes.index;
    }).length;

    final fastingList = sugarList.where((m) => m.isFasting == true).toList();
    final postMealList = sugarList.where((m) => m.isFasting != true).toList();

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfWidgets.header(AppTexts.pdfReportTitle, now),
          pw.SizedBox(height: 16),
          if (profile != null) ...[
            PdfWidgets.sectionTitle(AppTexts.pdfPatientInfo),
            pw.SizedBox(height: 6),
            PdfWidgets.infoGrid([
              if ((profile.name ?? '').trim().isNotEmpty)
                ['Ad Soyad', profile.name!.trim()],
              ['Yas', '${profile.age} yas'],
              ['Boy', '${profile.height.toStringAsFixed(0)} cm'],
              ['Kilo', '${profile.weight.toStringAsFixed(1)} kg'],
              ['Cinsiyet', profile.gender == 'male' ? 'Erkek' : 'Kadın'],
            ]),
            pw.SizedBox(height: 12),
          ],
          PdfWidgets.sectionTitle(AppTexts.pdfReportPeriod),
          pw.SizedBox(height: 4),
          pw.Text(
            '${DateFormat(AppConstants.dateFormatReport, 'tr').format(dateRange.start)} - ${DateFormat(AppConstants.dateFormatReport, 'tr').format(dateRange.end)}',
            style: PdfFontLoader.textStyle(
              color: PdfTheme.textSecond,
              fontSize: 10,
            ),
          ),
          pw.SizedBox(height: 12),
          PdfWidgets.sectionTitle(AppTexts.pdfGeneralSummary),
          pw.SizedBox(height: 6),
          pw.Row(
            children: [
              PdfWidgets.statBox(
                AppTexts.pdfBPMeasurement,
                '${bpList.length}',
                PdfTheme.primary,
              ),
              pw.SizedBox(width: 8),
              PdfWidgets.statBox(
                AppTexts.pdfBPExceeded,
                '$bpExceeded',
                PdfTheme.accent,
              ),
              pw.SizedBox(width: 8),
              PdfWidgets.statBox(
                AppTexts.pdfSugarMeasurement,
                '${sugarList.length}',
                PdfTheme.primary,
              ),
              pw.SizedBox(width: 8),
              PdfWidgets.statBox(
                AppTexts.pdfSugarExceeded,
                '$sugarExceeded',
                PdfTheme.accent,
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          if (bpList.isNotEmpty) ...[
            PdfWidgets.sectionTitle(AppTexts.pdfBPAverages),
            pw.SizedBox(height: 4),
            PdfWidgets.averageRow(
              AppTexts.pdfSystolicAvg,
              bpList.map((m) => m.value1).reduce((a, b) => a + b) /
                  bpList.length,
              'mmHg',
            ),
            PdfWidgets.averageRow(
              AppTexts.pdfDiastolicAvg,
              bpList.map((m) => m.value2 ?? 0).reduce((a, b) => a + b) /
                  bpList.length,
              'mmHg',
            ),
            pw.SizedBox(height: 8),
          ],
          if (sugarList.isNotEmpty) ...[
            PdfWidgets.sectionTitle(AppTexts.pdfSugarAverages),
            pw.SizedBox(height: 4),
            if (fastingList.isNotEmpty)
              PdfWidgets.averageRow(
                AppTexts.pdfFastingSugarAvg,
                fastingList.map((m) => m.value1).reduce((a, b) => a + b) /
                    fastingList.length,
                'mg/dL',
              ),
            if (postMealList.isNotEmpty)
              PdfWidgets.averageRow(
                AppTexts.pdfPostMealSugarAvg,
                postMealList.map((m) => m.value1).reduce((a, b) => a + b) /
                    postMealList.length,
                'mg/dL',
              ),
          ],
          pw.Spacer(),
          PdfWidgets.footer(pageNumber, totalPages),
        ],
      ),
    );
  }
}
