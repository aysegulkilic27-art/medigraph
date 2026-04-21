// PDF belgelerinde Türkçe karakter desteği için NotoSans
// fontlarını assets'ten yükleyen yardımcı sınıf. Singleton cache içerir.

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../core/constants/app_constants.dart';

class PdfFontLoader {
  PdfFontLoader._();

  static pw.Font? regular;
  static pw.Font? bold;

  static Future<void> load() async {
    if (regular != null && bold != null) {
      return;
    }

    final regularData = await rootBundle.load(AppConstants.fontRegularPath);
    final boldData = await rootBundle.load(AppConstants.fontBoldPath);

    regular = pw.Font.ttf(regularData);
    bold = pw.Font.ttf(boldData);
  }

  static pw.ThemeData get theme =>
      pw.ThemeData.withFont(base: regular!, bold: bold!);

  static pw.TextStyle textStyle({
    PdfColor? color,
    double? fontSize,
    pw.FontWeight? fontWeight,
  }) {
    return pw.TextStyle(
      font: regular,
      fontBold: bold,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
