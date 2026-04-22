// Tarih formatlama yardımcıları.

import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class AppDateUtils {
  static final DateFormat _dateTimeFormat = DateFormat(
    AppConstants.dateTimeFormat,
  );
  static final DateFormat _dateFormat = DateFormat(AppConstants.dateFormatFull);

  static String formatDateTime(DateTime dateTime) =>
      _dateTimeFormat.format(dateTime);

  static String formatDate(DateTime dateTime) => _dateFormat.format(dateTime);

  /// Doğum tarihinden yaşı hesaplar
  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    
    // Doğum günü bu yıl henüz gelmemişse yaştan 1 çıkar
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }
}
