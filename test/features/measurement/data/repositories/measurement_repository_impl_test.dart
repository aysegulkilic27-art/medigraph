import 'dart:io';

import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/data/models/measurement_hive_model.dart';
import 'package:diyabetansiyon/features/measurement/data/repositories/measurement_repository_impl.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late Directory tempDir;
  late Box<MeasurementHiveModel> box;
  late MeasurementRepositoryImpl repository;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MeasurementHiveModelAdapter());
    }
    box = await Hive.openBox<MeasurementHiveModel>('measurements_test');
    repository = MeasurementRepositoryImpl(box);
  });

  tearDown(() async {
    await box.close();
    await Hive.deleteBoxFromDisk('measurements_test');
    await tempDir.delete(recursive: true);
  });

  test('add ve getAll calisir', () async {
    final now = DateTime.now();
    final m = Measurement(
      id: '1',
      type: MeasurementType.bloodSugar,
      value1: 100,
      isFasting: true,
      dateTime: now,
    );

    await repository.addMeasurement(m);
    final all = await repository.getAll(null);

    expect(all.length, 1);
    expect(all.first.id, '1');
  });

  test('getByDateRange filtreler', () async {
    final now = DateTime.now();
    await repository.addMeasurement(
      Measurement(
        id: 'in',
        type: MeasurementType.bloodPressure,
        value1: 120,
        value2: 80,
        dateTime: now,
      ),
    );
    await repository.addMeasurement(
      Measurement(
        id: 'out',
        type: MeasurementType.bloodPressure,
        value1: 130,
        value2: 90,
        dateTime: now.subtract(const Duration(days: 30)),
      ),
    );

    final filtered = await repository.getByDateRange(
      now.subtract(const Duration(days: 2)),
      now.add(const Duration(days: 1)),
      null,
    );

    expect(filtered.map((e) => e.id).toList(), contains('in'));
    expect(filtered.map((e) => e.id).toList(), isNot(contains('out')));
  });

  group('getByType Filtresi', () {
    test('Sadece bloodPressure tipini dondurur', () async {
      final now = DateTime.now();
      await repository.addMeasurement(
        Measurement(
          id: 'bp_1',
          type: MeasurementType.bloodPressure,
          value1: 120,
          value2: 80,
          dateTime: now,
        ),
      );
      await repository.addMeasurement(
        Measurement(
          id: 'sugar_1',
          type: MeasurementType.bloodSugar,
          value1: 110,
          isFasting: true,
          dateTime: now,
        ),
      );

      final results = await repository.getByType(
        MeasurementType.bloodPressure,
        null,
      );

      expect(
        results.every((m) => m.type == MeasurementType.bloodPressure),
        isTrue,
      );
      expect(results.length, 1);
    });

    test('getAll tarihe gore yeniden eskiye siralanmis doner', () async {
      final olderDate = DateTime(2024, 1, 1);
      final newerDate = DateTime(2024, 6, 1);
      await repository.addMeasurement(
        Measurement(
          id: 'older',
          type: MeasurementType.bloodPressure,
          value1: 120,
          value2: 80,
          dateTime: olderDate,
        ),
      );
      await repository.addMeasurement(
        Measurement(
          id: 'newer',
          type: MeasurementType.bloodPressure,
          value1: 130,
          value2: 85,
          dateTime: newerDate,
        ),
      );

      final results = await repository.getAll(null);

      expect(results.first.dateTime.isAfter(results.last.dateTime), isTrue);
    });
  });

  group('deleteAll', () {
    test('tum kayitlari siler', () async {
      final now = DateTime.now();
      await repository.addMeasurement(
        Measurement(
          id: '1',
          type: MeasurementType.bloodSugar,
          value1: 100,
          isFasting: true,
          dateTime: now,
        ),
      );
      await repository.addMeasurement(
        Measurement(
          id: '2',
          type: MeasurementType.bloodPressure,
          value1: 120,
          value2: 80,
          dateTime: now,
        ),
      );

      await repository.deleteAll();
      final all = await repository.getAll(null);

      expect(all, isEmpty);
    });

    test('bos kutuda deleteAll hata firlatmaz', () async {
      expect(() => repository.deleteAll(), returnsNormally);
    });
  });
}
