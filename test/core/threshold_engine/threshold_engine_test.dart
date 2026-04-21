import 'package:diyabetansiyon/core/enums/blood_pressure_stage.dart';
import 'package:diyabetansiyon/core/enums/blood_sugar_stage.dart';
import 'package:diyabetansiyon/core/threshold_engine/threshold_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThresholdEngine', () {
    final engine = ThresholdEngine.instance;

    test('105 aclik sekeri prediyabet olmali (WHO/ADA)', () {
      expect(
        engine.evaluateSugarStage(value: 105, isFasting: true),
        BloodSugarStage.prediabetes,
      );
    });

    group('BloodSugar - Aclik Sinir Degerleri', () {
      test('69 -> hipoglisemi', () {
        expect(
          engine.evaluateSugarStage(value: 69, isFasting: true),
          BloodSugarStage.hypoglycemia,
        );
      });

      test('70 -> normal (alt sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 70, isFasting: true),
          BloodSugarStage.normal,
        );
      });

      test('99 -> normal (ust sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 99, isFasting: true),
          BloodSugarStage.normal,
        );
      });

      test('100 -> prediyabet (alt sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 100, isFasting: true),
          BloodSugarStage.prediabetes,
        );
      });

      test('125 -> prediyabet (ust sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 125, isFasting: true),
          BloodSugarStage.prediabetes,
        );
      });

      test('126 -> diyabet (alt sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 126, isFasting: true),
          BloodSugarStage.diabetes,
        );
      });
    });

    group('BloodSugar - Tokluk Sinir Degerleri', () {
      test('139 -> normal (ust sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 139, isFasting: false),
          BloodSugarStage.normal,
        );
      });

      test('140 -> prediyabet (alt sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 140, isFasting: false),
          BloodSugarStage.prediabetes,
        );
      });

      test('199 -> prediyabet (ust sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 199, isFasting: false),
          BloodSugarStage.prediabetes,
        );
      });

      test('200 -> diyabet (alt sinir)', () {
        expect(
          engine.evaluateSugarStage(value: 200, isFasting: false),
          BloodSugarStage.diabetes,
        );
      });
    });

    group('BloodPressure - Eriskin Sinir Degerleri (AHA 2017)', () {
      test('119/79 -> normal (ust sinir)', () {
        expect(
          engine.evaluateBPStage(systolic: 119, diastolic: 79, age: 30),
          BloodPressureStage.normal,
        );
      });

      test('120/79 -> elevated (alt sinir sistolik)', () {
        expect(
          engine.evaluateBPStage(systolic: 120, diastolic: 79, age: 30),
          BloodPressureStage.elevated,
        );
      });

      test('129/79 -> elevated (ust sinir)', () {
        expect(
          engine.evaluateBPStage(systolic: 129, diastolic: 79, age: 30),
          BloodPressureStage.elevated,
        );
      });

      test('130/79 -> stage1', () {
        expect(
          engine.evaluateBPStage(systolic: 130, diastolic: 79, age: 30),
          BloodPressureStage.stage1,
        );
      });

      test('139/89 -> stage1 (ust sinir)', () {
        expect(
          engine.evaluateBPStage(systolic: 139, diastolic: 89, age: 30),
          BloodPressureStage.stage1,
        );
      });

      test('140/90 -> stage2 (alt sinir)', () {
        expect(
          engine.evaluateBPStage(systolic: 140, diastolic: 90, age: 30),
          BloodPressureStage.stage2,
        );
      });

      test('181/121 -> crisis', () {
        expect(
          engine.evaluateBPStage(systolic: 181, diastolic: 121, age: 30),
          BloodPressureStage.crisis,
        );
      });

      test('180/80 -> stage2 (crisis degil, sadece sys esigi)', () {
        expect(
          engine.evaluateBPStage(systolic: 180, diastolic: 80, age: 30),
          BloodPressureStage.stage2,
        );
      });

      test('120/121 -> crisis (sadece dia esigi asildi)', () {
        expect(
          engine.evaluateBPStage(systolic: 120, diastolic: 121, age: 30),
          BloodPressureStage.crisis,
        );
      });

      test('181/80 -> crisis (sadece sys esigi asildi)', () {
        expect(
          engine.evaluateBPStage(systolic: 181, diastolic: 80, age: 30),
          BloodPressureStage.crisis,
        );
      });

      test('89/59 -> hypotension (dusuk)', () {
        expect(
          engine.evaluateBPStage(systolic: 89, diastolic: 59, age: 30),
          BloodPressureStage.hypotension,
        );
      });

      test('Celisik: sys normal dia stage2 -> stage2 doner', () {
        expect(
          engine.evaluateBPStage(systolic: 115, diastolic: 90, age: 30),
          BloodPressureStage.stage2,
        );
      });
    });

    group('BloodPressure - Pediatrik', () {
      test('Erkek 10 yas normal aralik -> normal', () {
        expect(
          engine.evaluateBPStage(
            systolic: 95,
            diastolic: 55,
            age: 10,
            gender: 'male',
          ),
          BloodPressureStage.normal,
        );
      });

      test('Erkek 10 yas 95p ustu -> stage1 veya ustu', () {
        final stage = engine.evaluateBPStage(
          systolic: 116,
          diastolic: 75,
          age: 10,
          gender: 'male',
        );

        expect(
          stage == BloodPressureStage.stage1 ||
              stage == BloodPressureStage.stage2 ||
              stage == BloodPressureStage.crisis,
          isTrue,
        );
      });
    });
  });
}
