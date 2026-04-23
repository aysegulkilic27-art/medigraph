import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/measurement/domain/repositories/measurement_repository.dart';
import 'package:diyabetansiyon/features/measurement/domain/usecases/add_measurement_usecase.dart';
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
  test('AddMeasurementUseCase olcum kaydeder', () async {
    final repo = _FakeMeasurementRepo();
    final useCase = AddMeasurementUseCase(repo);

    await useCase.execute(
      type: MeasurementType.bloodSugar,
      value1: 140,
      isFasting: true,
    );

    expect(repo.saved.length, 1);
    expect(repo.saved.first.type, MeasurementType.bloodSugar);
    expect(repo.saved.first.value1, 140);
  });

  test('AddMeasurementUseCase note alanini kaydeder', () async {
    final repo = _FakeMeasurementRepo();
    final useCase = AddMeasurementUseCase(repo);

    await useCase.execute(
      type: MeasurementType.bloodSugar,
      value1: 140,
      isFasting: true,
      note: 'Test notu',
    );

    expect(repo.saved.first.note, 'Test notu');
  });

  test('AddMeasurementUseCase tansiyon icin value2 kaydeder', () async {
    final repo = _FakeMeasurementRepo();
    final useCase = AddMeasurementUseCase(repo);

    await useCase.execute(
      type: MeasurementType.bloodPressure,
      value1: 120,
      value2: 80,
    );

    expect(repo.saved.first.value2, 80);
    expect(repo.saved.first.type, MeasurementType.bloodPressure);
  });

  test('AddMeasurementUseCase note null olabilir', () async {
    final repo = _FakeMeasurementRepo();
    final useCase = AddMeasurementUseCase(repo);

    await useCase.execute(
      type: MeasurementType.bloodSugar,
      value1: 90,
      isFasting: false,
    );

    expect(repo.saved.first.note, isNull);
  });
}
