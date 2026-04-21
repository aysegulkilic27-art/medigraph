// Tek bir ölçüm kaydını temsil eden domain entity. Tansiyon ve şeker
// ölçümlerini ortak bir model altında birleştirir.

import 'package:diyabetansiyon/core/enums/measurement_type.dart';

class Measurement {
  final String id;
  final MeasurementType type;
  final double value1;
  final double? value2;
  final bool? isFasting;
  final DateTime dateTime;
  final String? note;
  final String? profileId;

  const Measurement({
    required this.id,
    required this.type,
    required this.value1,
    this.value2,
    this.isFasting,
    required this.dateTime,
    this.note,
    this.profileId,
  });
}
