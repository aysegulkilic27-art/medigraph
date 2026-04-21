// PDF sayfalarında ortak kullanılan header, footer, istatistik
// kutusu gibi yeniden kullanılabilir widget fonksiyonları.

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_texts.dart';
import 'pdf_font_loader.dart';
import 'pdf_theme.dart';

class PdfWidgets {
  PdfWidgets._();

  static pw.Widget header(String title, DateTime? date) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        gradient: const pw.LinearGradient(
          colors: [PdfTheme.primaryDark, PdfTheme.primary],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: PdfFontLoader.textStyle(
                  color: PdfColors.white,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (date != null)
                pw.Text(
                  DateFormat(AppConstants.dateFormatReport, 'tr').format(date),
                  style: PdfFontLoader.textStyle(
                    color: PdfColors.white,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
          pw.Text(
            AppTexts.pdfAppName,
            textAlign: pw.TextAlign.right,
            style: PdfFontLoader.textStyle(
              color: PdfTheme.white70,
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget footer(int page, int total) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          AppTexts.pdfFooterDisclaimer,
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textSecond,
            fontSize: 7,
          ),
        ),
        pw.Text(
          '$page / $total',
          style: PdfFontLoader.textStyle(
            color: PdfTheme.textSecond,
            fontSize: 8,
          ),
        ),
      ],
    );
  }

  static pw.Widget sectionTitle(String text) {
    return pw.Text(
      text,
      style: PdfFontLoader.textStyle(
        color: PdfTheme.primaryDark,
        fontSize: 11,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  static pw.Widget statBox(String label, String value, PdfColor color) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: color,
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              value,
              style: PdfFontLoader.textStyle(
                color: PdfColors.white,
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              label,
              textAlign: pw.TextAlign.center,
              style: PdfFontLoader.textStyle(
                color: PdfTheme.white70,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget averageRow(String label, double value, String unit) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: PdfFontLoader.textStyle(
              fontSize: 9,
              color: PdfTheme.textPrimary,
            ),
          ),
          pw.Text(
            '${value.toStringAsFixed(1)} $unit',
            style: PdfFontLoader.textStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfTheme.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget infoGrid(List<List<String>> items) {
    return pw.Wrap(
      spacing: 12,
      runSpacing: 6,
      children: items
          .map(
            (item) => pw.Row(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(
                  '${item[0]}: ',
                  style: PdfFontLoader.textStyle(
                    color: PdfTheme.textSecond,
                    fontSize: 9,
                  ),
                ),
                pw.Text(
                  item[1],
                  style: PdfFontLoader.textStyle(
                    color: PdfTheme.textPrimary,
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
