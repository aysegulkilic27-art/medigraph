// MeasurementRepository arayüzünün Hive tabanlı gerçekleştirimi.
// Ölçüm verilerini yerel veritabanında okur ve yazar.

import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/data/models/measurement_hive_model.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/measurement/domain/repositories/measurement_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

extension MeasurementHiveMapper on MeasurementHiveModel {
  Measurement toEntity() => Measurement(
    id: id,
    type: MeasurementType.values.byName(type),
    value1: value1,
    value2: value2,
    isFasting: isFasting,
    dateTime: dateTime,
    note: note,
    profileId: profileId,
  );
}

extension MeasurementMapper on Measurement {
  MeasurementHiveModel toHiveModel() => MeasurementHiveModel()
    ..id = id
    ..type = type.name
    ..value1 = value1
    ..value2 = value2
    ..isFasting = isFasting
    ..dateTime = dateTime
    ..note = note
    ..profileId = profileId;
}

class MeasurementRepositoryImpl implements MeasurementRepository {
  final Box<MeasurementHiveModel> box;

  MeasurementRepositoryImpl(this.box);

  @override
  Future<void> addMeasurement(Measurement measurement) async {
    await box.put(measurement.id, measurement.toHiveModel());
  }

  @override
  Future<void> deleteMeasurement(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> deleteAll() async {
    try {
      await box.clear();
    } catch (e) {
      debugPrint('DeleteAll error: $e');
      rethrow;
    }
  }

  @override
  Future<List<Measurement>> getAll(String? profileId) async {
    return box.values
        .where((e) => e.profileId == profileId)
        .map((e) => e.toEntity())
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  @override
  Future<List<Measurement>> getByDateRange(
      DateTime from, DateTime to, String? profileId) async {
    return box.values
        .where((e) =>
            e.profileId == profileId &&
            !e.dateTime.isBefore(from) &&
            !e.dateTime.isAfter(to))
        .map((e) => e.toEntity())
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  @override
  Future<List<Measurement>> getByType(
      MeasurementType type, String? profileId) async {
    return box.values
        .where((e) => e.profileId == profileId && e.type == type.name)
        .map((e) => e.toEntity())
        .toList();
  }
}
