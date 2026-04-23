import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/measurement/domain/repositories/measurement_repository.dart';
import 'package:diyabetansiyon/features/measurement/domain/usecases/delete_all_measurements_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeMeasurementRepo implements MeasurementRepository {
  final List<Measurement> saved = [];

  @override
  Future<void> addMeasurement(Measurement measurement) async {
    saved.add(measurement);
  }

  @override
  Future<void> deleteMeasurement(String id) async {
    saved.removeWhere((m) => m.id == id);
  }

  @override
  Future<void> deleteAll() async {
    saved.clear();
  }

  @override
  Future<List<Measurement>> getAll(String? profileId) async => saved;

  @override
  Future<List<Measurement>> getByDateRange(
    DateTime from,
    DateTime to,
    String? profileId,
  ) async => saved;

  @override
  Future<List<Measurement>> getByType(
    MeasurementType type,
    String? profileId,
  ) async => saved.where((m) => m.type == type).toList();
}

void main() {
  test('DeleteAllMeasurementsUseCase tum kayitlari siler', () async {
    final repo = _FakeMeasurementRepo();
    final useCase = DeleteAllMeasurementsUseCase(repo);

    await repo.addMeasurement(
      Measurement(
        id: '1',
        type: MeasurementType.bloodSugar,
        value1: 100,
        isFasting: true,
        dateTime: DateTime.now(),
      ),
    );

    expect(repo.saved.length, 1);

    await useCase.execute();

    expect(repo.saved, isEmpty);
  });

  test('DeleteAllMeasurementsUseCase bos repoda hata firlatmaz', () async {
    final repo = _FakeMeasurementRepo();
    final useCase = DeleteAllMeasurementsUseCase(repo);

    expect(() => useCase.execute(), returnsNormally);
  });
}
