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
}
