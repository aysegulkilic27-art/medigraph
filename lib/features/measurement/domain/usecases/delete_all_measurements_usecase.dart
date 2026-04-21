// Tüm ölçüm verilerini kalıcı olarak silen use case.

import 'package:diyabetansiyon/features/measurement/domain/repositories/measurement_repository.dart';

class DeleteAllMeasurementsUseCase {
  final MeasurementRepository repository;

  DeleteAllMeasurementsUseCase(this.repository);

  Future<void> execute() async {
    await repository.deleteAll();
  }
}
