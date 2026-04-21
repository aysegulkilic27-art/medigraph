// PDF belgelerinde kullanılan renk paleti ve stage renk çözümleyicisi.

import 'package:pdf/pdf.dart';

class PdfTheme {
  PdfTheme._();

  static const primary = PdfColor.fromInt(0xFF00897B);
  static const primaryDark = PdfColor.fromInt(0xFF00695C);
  static const accent = PdfColor.fromInt(0xFFFF7043);
  static const surface = PdfColor.fromInt(0xFFFFFFFF);
  static const bgLight = PdfColor.fromInt(0xFFF5F5F5);
  static const textPrimary = PdfColor.fromInt(0xFF212121);
  static const textSecond = PdfColor.fromInt(0xFF757575);
  static const white70 = PdfColor(1, 1, 1, 0.7);

  static PdfColor stageColor(String stage) {
    return switch (stage) {
      'Hipoglisemi' ||
      'Dusuk' ||
      'Düşük' ||
      'Düşük' => PdfColor.fromInt(0xFF42A5F5),
      'Normal' => PdfColor.fromInt(0xFF26A69A),
      'Yuksek Normal' || 'Yüksek Normal' => PdfColor.fromInt(0xFFFFB300),
      'Evre 1' || 'Prediyabet' => PdfColor.fromInt(0xFFFF7043),
      'Evre 2' || 'Diyabet' => PdfColor.fromInt(0xFFEF5350),
      'Kriz' => PdfColor.fromInt(0xFF7B0000),
      _ => PdfColor.fromInt(0xFF757575),
    };
  }
}
