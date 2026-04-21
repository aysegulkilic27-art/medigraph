// Ölçüm verilerini Riverpod ile yöneten provider'lar.
// Tüm ölçümleri ve tip bazlı filtrelenmiş listeleri sağlar.

import 'package:diyabetansiyon/core/models/date_range.dart';
import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/data/models/measurement_hive_model.dart';
import 'package:diyabetansiyon/features/measurement/data/repositories/measurement_repository_impl.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/measurement/domain/repositories/measurement_repository.dart';
import 'package:diyabetansiyon/features/measurement/domain/usecases/add_measurement_usecase.dart';
import 'package:diyabetansiyon/features/measurement/domain/usecases/delete_all_measurements_usecase.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'measurement_provider.g.dart';

@riverpod
Box<MeasurementHiveModel> measurementBox(MeasurementBoxRef ref) {
  return Hive.box<MeasurementHiveModel>('measurements');
}

@riverpod
MeasurementRepository measurementRepository(MeasurementRepositoryRef ref) {
  return MeasurementRepositoryImpl(ref.watch(measurementBoxProvider));
}

@riverpod
AddMeasurementUseCase addMeasurementUseCase(AddMeasurementUseCaseRef ref) {
  return AddMeasurementUseCase(ref.watch(measurementRepositoryProvider));
}

final deleteAllMeasurementsUseCaseProvider = Provider<DeleteAllMeasurementsUseCase>(
  (ref) => DeleteAllMeasurementsUseCase(ref.read(measurementRepositoryProvider)),
);

@riverpod
Future<List<Measurement>> allMeasurements(AllMeasurementsRef ref) async {
  final activeProfile = ref.watch(activeProfileProvider);
  return ref.watch(measurementRepositoryProvider).getAll(activeProfile?.id);
}

@riverpod
Future<List<Measurement>> filteredMeasurements(
  FilteredMeasurementsRef ref, {
  required MeasurementType type,
  required DateRange range,
}) async {
  final activeProfile = ref.watch(activeProfileProvider);
  final repo = ref.watch(measurementRepositoryProvider);
  return repo
      .getByDateRange(range.start, range.end, activeProfile?.id)
      .then((list) => list.where((m) => m.type == type).toList());
}
