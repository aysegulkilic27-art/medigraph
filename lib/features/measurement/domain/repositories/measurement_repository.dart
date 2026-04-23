// Ölçüm verilerine erişim için soyut repository arayüzü.

import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';

abstract class MeasurementRepository {
  Future<void> addMeasurement(Measurement measurement);
  Future<void> deleteMeasurement(String id);
  Future<void> deleteAll();
  Future<List<Measurement>> getAll(String? profileId);
  Future<List<Measurement>> getByDateRange(DateTime from, DateTime to, String? profileId);
  Future<List<Measurement>> getByType(MeasurementType type, String? profileId);
}
