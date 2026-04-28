// PDF içine manuel olarak çizgi grafik çizen CustomPaint tabanlı sınıf.
// Her nokta klinik evreye göre renklendirilir.

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_texts.dart';
import '../../features/measurement/domain/entities/measurement.dart';
import 'pdf_font_loader.dart';
import 'pdf_theme.dart';
import 'pdf_weekly_aggregate.dart';

class PdfChartPainter {
  PdfChartPainter._();

  static pw.Widget weeklyMinAvgMaxChart({
    required List<WeeklyTriple> points,
    required String unit,
    required double height,
  }) {
    if (points.isEmpty) {
      return pw.Container(
        height: height,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          color: PdfTheme.bgLight,
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Text(
          AppTexts.pdfNoData,
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textSecond,
            fontSize: 9,
          ),
        ),
      );
    }

    final sorted = [...points]
      ..sort((a, b) => a.weekStart.compareTo(b.weekStart));
    final allValues = [
      ...sorted.map((e) => e.min),
      ...sorted.map((e) => e.avg),
      ...sorted.map((e) => e.max),
    ];

    final minRaw = allValues.reduce((a, b) => a < b ? a : b);
    final maxRaw = allValues.reduce((a, b) => a > b ? a : b);
    final padding = ((maxRaw - minRaw).abs() * 0.15).clamp(5.0, 20.0);
    final minVal = minRaw - padding;
    final maxVal = maxRaw + padding;
    final range = (maxVal - minVal).abs() < 0.0001 ? 1.0 : maxVal - minVal;

    return pw.Container(
      height: height,
      decoration: pw.BoxDecoration(
        color: PdfTheme.bgLight,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      padding: const pw.EdgeInsets.fromLTRB(24, 8, 8, 16),
      child: pw.CustomPaint(
        size: PdfPoint.zero,
        painter: (canvas, size) {
          final w = size.x;
          final h = size.y;
          final n = sorted.length;

          canvas.setStrokeColor(PdfColors.grey300);
          canvas.setLineWidth(0.4);
          for (int i = 0; i <= 4; i++) {
            final y = h - (h * i / 4);
            canvas.moveTo(0, y);
            canvas.lineTo(w, y);
            canvas.strokePath();

            final val = (minVal + range * i / 4).toStringAsFixed(0);
            canvas.setFillColor(PdfTheme.textSecond);
            final font = canvas.defaultFont;
            if (font != null) {
              canvas.drawString(font, 6, val, -16, y - 2);
            }
          }

          void drawSeries(List<double> values, PdfColor color, double width) {
            if (n < 2) return;
            canvas.setStrokeColor(color);
            canvas.setLineWidth(width);
            for (int i = 1; i < n; i++) {
              final prevX = w * (i - 1) / (n - 1);
              final x = w * i / (n - 1);
              final prevY = h - (h * (values[i - 1] - minVal) / range);
              final y = h - (h * (values[i] - minVal) / range);
              canvas.moveTo(prevX, prevY);
              canvas.lineTo(x, y);
              canvas.strokePath();
            }
          }

          final minSeries = sorted.map((e) => e.min).toList();
          final avgSeries = sorted.map((e) => e.avg).toList();
          final maxSeries = sorted.map((e) => e.max).toList();

          drawSeries(minSeries, PdfTheme.primary, 1.0);
          drawSeries(avgSeries, PdfTheme.primaryDark, 1.6);
          drawSeries(maxSeries, PdfTheme.accent, 1.0);

          for (int i = 0; i < n; i++) {
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final yAvg = h - (h * (avgSeries[i] - minVal) / range);
            canvas.setFillColor(PdfTheme.primaryDark);
            canvas.drawEllipse(x, yAvg, 2.0, 2.0);
            canvas.fillPath();
          }

          final labelIndices = <int>{
            0,
            if (n > 2) (n / 2).floor(),
            if (n > 3) (n * 0.75).floor(),
            if (n > 1) n - 1,
          }.toList()..sort();

          for (final i in labelIndices) {
            final dateStr = DateFormat('dd/MM').format(sorted[i].weekStart);
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            canvas.setFillColor(PdfTheme.textSecond);
            final font = canvas.defaultFont;
            if (font != null) {
              canvas.drawString(font, 5, dateStr, x - 10, -9);
            }
          }

          canvas.setFillColor(PdfTheme.textSecond);
          final font = canvas.defaultFont;
          if (font != null) {
            canvas.drawString(font, 6, unit, w - 20, h - 8);
          }
        },
      ),
    );
  }

  static pw.Widget dualLineChart({
    required List<Measurement> measurements,
    required double Function(Measurement) getPrimaryValue,
    required double Function(Measurement) getSecondaryValue,
    required PdfColor Function(Measurement) getPointColor,
    required String unit,
    required double height,
  }) {
    if (measurements.isEmpty) {
      return pw.Container(
        height: height,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          color: PdfTheme.bgLight,
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Text(
          AppTexts.pdfNoData,
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textSecond,
            fontSize: 9,
          ),
        ),
      );
    }

    final sorted = [...measurements]
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final primaryValues = sorted.map(getPrimaryValue).toList();
    final secondaryValues = sorted.map(getSecondaryValue).toList();
    final allValues = [...primaryValues, ...secondaryValues];

    final minRaw = allValues.reduce((a, b) => a < b ? a : b);
    final maxRaw = allValues.reduce((a, b) => a > b ? a : b);
    final padding = ((maxRaw - minRaw).abs() * 0.15).clamp(5.0, 20.0);
    final minVal = minRaw - padding;
    final maxVal = maxRaw + padding;
    final range = (maxVal - minVal).abs() < 0.0001 ? 1.0 : maxVal - minVal;

    return pw.Container(
      height: height,
      decoration: pw.BoxDecoration(
        color: PdfTheme.bgLight,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      padding: const pw.EdgeInsets.fromLTRB(24, 8, 8, 16),
      child: pw.CustomPaint(
        size: PdfPoint.zero,
        painter: (canvas, size) {
          final w = size.x;
          final h = size.y;
          final n = sorted.length;

          canvas.setStrokeColor(PdfColors.grey300);
          canvas.setLineWidth(0.4);
          for (int i = 0; i <= 4; i++) {
            final y = h - (h * i / 4);
            canvas.moveTo(0, y);
            canvas.lineTo(w, y);
            canvas.strokePath();

            final val = (minVal + range * i / 4).toStringAsFixed(0);
            canvas.setFillColor(PdfTheme.textSecond);
            final font = canvas.defaultFont;
            if (font != null) {
              canvas.drawString(font, 6, val, -16, y - 2);
            }
          }

          // Büyük tansiyon çizgisi
          canvas.setStrokeColor(PdfTheme.primaryDark);
          canvas.setLineWidth(1.3);
          for (int i = 1; i < n; i++) {
            final prevVal = getPrimaryValue(sorted[i - 1]);
            final val = getPrimaryValue(sorted[i]);
            final prevX = n == 1 ? w / 2 : w * (i - 1) / (n - 1);
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final prevY = h - (h * (prevVal - minVal) / range);
            final y = h - (h * (val - minVal) / range);
            canvas.moveTo(prevX, prevY);
            canvas.lineTo(x, y);
            canvas.strokePath();
          }

          // Küçük tansiyon çizgisi
          canvas.setStrokeColor(PdfTheme.accent);
          canvas.setLineWidth(1.3);
          for (int i = 1; i < n; i++) {
            final prevVal = getSecondaryValue(sorted[i - 1]);
            final val = getSecondaryValue(sorted[i]);
            final prevX = n == 1 ? w / 2 : w * (i - 1) / (n - 1);
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final prevY = h - (h * (prevVal - minVal) / range);
            final y = h - (h * (val - minVal) / range);
            canvas.moveTo(prevX, prevY);
            canvas.lineTo(x, y);
            canvas.strokePath();
          }

          // Evre rengine göre nokta işaretleri
          for (int i = 0; i < n; i++) {
            final m = sorted[i];
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final yPrimary = h - (h * (getPrimaryValue(m) - minVal) / range);
            final ySecondary =
                h - (h * (getSecondaryValue(m) - minVal) / range);

            canvas.setFillColor(getPointColor(m));
            canvas.drawEllipse(x, yPrimary, 2.0, 2.0);
            canvas.fillPath();
            canvas.drawEllipse(x, ySecondary, 2.0, 2.0);
            canvas.fillPath();
          }

          final labelIndices = <int>{
            0,
            if (n > 2) (n / 2).floor(),
            if (n > 3) (n * 0.75).floor(),
            if (n > 1) n - 1,
          }.toList()..sort();

          for (final i in labelIndices) {
            final m = sorted[i];
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final dateStr = DateFormat(
              AppConstants.dateFormatShort,
            ).format(m.dateTime);
            canvas.setFillColor(PdfTheme.textSecond);
            final font = canvas.defaultFont;
            if (font != null) {
              canvas.drawString(font, 5, dateStr, x - 9, -9);
            }
          }

          canvas.setFillColor(PdfTheme.textSecond);
          final font = canvas.defaultFont;
          if (font != null) {
            canvas.drawString(font, 6, unit, w - 20, h - 8);
          }
        },
      ),
    );
  }

  static pw.Widget lineChart({
    required List<Measurement> measurements,
    required double Function(Measurement) getValue,
    required PdfColor Function(Measurement) getColor,
    required String unit,
    required double height,
  }) {
    if (measurements.isEmpty) {
      return pw.Container(
        height: height,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          color: PdfTheme.bgLight,
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Text(
          AppTexts.pdfNoData,
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textSecond,
            fontSize: 9,
          ),
        ),
      );
    }

    final sorted = [...measurements]
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final values = sorted.map(getValue).toList();
    final minRaw = values.reduce((a, b) => a < b ? a : b);
    final maxRaw = values.reduce((a, b) => a > b ? a : b);
    final padding = ((maxRaw - minRaw).abs() * 0.15).clamp(5.0, 20.0);
    final minVal = minRaw - padding;
    final maxVal = maxRaw + padding;
    final range = (maxVal - minVal).abs() < 0.0001 ? 1.0 : maxVal - minVal;

    return pw.Container(
      height: height,
      decoration: pw.BoxDecoration(
        color: PdfTheme.bgLight,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      padding: const pw.EdgeInsets.fromLTRB(24, 8, 8, 16),
      child: pw.CustomPaint(
        size: PdfPoint.zero,
        painter: (canvas, size) {
          final w = size.x;
          final h = size.y;
          final n = sorted.length;

          // Arka plan yatay kılavuz çizgileri
          canvas.setStrokeColor(PdfColors.grey300);
          canvas.setLineWidth(0.4);
          for (int i = 0; i <= 4; i++) {
            final y = h - (h * i / 4);
            canvas.moveTo(0, y);
            canvas.lineTo(w, y);
            canvas.strokePath();

            final val = (minVal + range * i / 4).toStringAsFixed(0);
            canvas.setFillColor(PdfTheme.textSecond);
            final font = canvas.defaultFont;
            if (font != null) {
              canvas.drawString(font, 6, val, -16, y - 2);
            }
          }

          // Ana çizgi (line chart)
          canvas.setStrokeColor(PdfTheme.primary);
          canvas.setLineWidth(1.2);
          for (int i = 0; i < n; i++) {
            final m = sorted[i];
            final val = getValue(m);
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final y = h - (h * (val - minVal) / range);

            if (i > 0) {
              final prevVal = getValue(sorted[i - 1]);
              final prevX = n == 1 ? w / 2 : w * (i - 1) / (n - 1);
              final prevY = h - (h * (prevVal - minVal) / range);
              canvas.moveTo(prevX, prevY);
              canvas.lineTo(x, y);
              canvas.strokePath();
            }

            // Nokta işaretleri
            canvas.setFillColor(getColor(m));
            canvas.drawEllipse(x, y, 2.2, 2.2);
            canvas.fillPath();
          }

          // X ekseninde sabit sayıda tarih etiketi göster (çakışmayı azaltır)
          final labelIndices = <int>{
            0,
            if (n > 2) (n / 2).floor(),
            if (n > 3) (n * 0.75).floor(),
            if (n > 1) n - 1,
          }.toList()..sort();

          for (final i in labelIndices) {
            final m = sorted[i];
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final dateStr = DateFormat(
              AppConstants.dateFormatShort,
            ).format(m.dateTime);
            canvas.setFillColor(PdfTheme.textSecond);
            final font = canvas.defaultFont;
            if (font != null) {
              canvas.drawString(font, 5, dateStr, x - 9, -9);
            }
          }

          canvas.setFillColor(PdfTheme.textSecond);
          final font = canvas.defaultFont;
          if (font != null) {
            canvas.drawString(font, 6, unit, w - 20, h - 8);
          }
        },
      ),
    );
  }
}
