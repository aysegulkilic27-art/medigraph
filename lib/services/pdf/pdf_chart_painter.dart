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

class PdfChartPainter {
  PdfChartPainter._();

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

    final values = measurements.map(getValue).toList();
    final minRaw = values.reduce((a, b) => a < b ? a : b);
    final maxRaw = values.reduce((a, b) => a > b ? a : b);
    final minVal = minRaw - 10;
    final maxVal = maxRaw + 10;
    final range = (maxVal - minVal).abs() < 0.0001 ? 1.0 : maxVal - minVal;

    return pw.Container(
      height: height,
      decoration: pw.BoxDecoration(
        color: PdfTheme.bgLight,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      padding: const pw.EdgeInsets.fromLTRB(20, 8, 8, 14),
      child: pw.CustomPaint(
        size: PdfPoint.zero,
        painter: (canvas, size) {
          final w = size.x;
          final h = size.y;
          final n = measurements.length;

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

          for (int i = 0; i < n; i++) {
            final m = measurements[i];
            final val = getValue(m);
            final x = n == 1 ? w / 2 : w * i / (n - 1);
            final y = h - (h * (val - minVal) / range);

            if (i > 0) {
              final prevVal = getValue(measurements[i - 1]);
              final prevX = n == 1 ? w / 2 : w * (i - 1) / (n - 1);
              final prevY = h - (h * (prevVal - minVal) / range);
              canvas.setStrokeColor(PdfTheme.primary);
              canvas.setLineWidth(1.0);
              canvas.moveTo(prevX, prevY);
              canvas.lineTo(x, y);
              canvas.strokePath();
            }

            canvas.setFillColor(getColor(m));
            canvas.drawEllipse(x, y, 2.2, 2.2);
            canvas.fillPath();

            if (i % 3 == 0 || n <= 5 || i == n - 1) {
              final dateStr = DateFormat(
                AppConstants.dateFormatShort,
              ).format(m.dateTime);
              canvas.setFillColor(PdfTheme.textSecond);
              final font = canvas.defaultFont;
              if (font != null) {
                canvas.drawString(font, 5, dateStr, x - 8, -8);
              }
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
