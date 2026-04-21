// Yeni bir ölçüm kaydı oluşturup repository'e ekleyen use case.

import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/measurement/domain/repositories/measurement_repository.dart';
import 'package:uuid/uuid.dart';

class AddMeasurementUseCase {
  final MeasurementRepository repository;
  AddMeasurementUseCase(this.repository);

  Future<void> execute({
    required MeasurementType type,
    required double value1,
    double? value2,
    bool? isFasting,
    String? note,
    String? profileId,
  }) async {
    final measurement = Measurement(
      id: const Uuid().v4(),
      type: type,
      value1: value1,
      value2: value2,
      isFasting: isFasting,
      dateTime: DateTime.now(),
      note: note,
      profileId: profileId,
    );
    await repository.addMeasurement(measurement);
  }
}
