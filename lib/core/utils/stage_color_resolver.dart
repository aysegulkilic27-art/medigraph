// Klinik evreye göre UI rengi döndüren yardımcı sınıf.
// Eşik aşımı kontrolü ve stage etiketini de sağlar.

import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/blood_pressure_stage.dart';
import 'package:diyabetansiyon/core/enums/blood_sugar_stage.dart';
import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/core/threshold_engine/threshold_engine.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:flutter/material.dart';

class StageColorResolver {
  static Color fromBPStage(BloodPressureStage stage) => switch (stage) {
    BloodPressureStage.hypotension => AppColors.bpHypotension,
    BloodPressureStage.normal => AppColors.bpNormal,
    BloodPressureStage.elevated => AppColors.bpElevated,
    BloodPressureStage.stage1 => AppColors.bpStage1,
    BloodPressureStage.stage2 => AppColors.bpStage2,
    BloodPressureStage.crisis => AppColors.bpCrisis,
  };

  static Color fromSugarStage(BloodSugarStage stage) => switch (stage) {
    BloodSugarStage.hypoglycemia => AppColors.sugarHypo,
    BloodSugarStage.normal => AppColors.sugarNormal,
    BloodSugarStage.prediabetes => AppColors.sugarPrediabet,
    BloodSugarStage.diabetes => AppColors.sugarDiabet,
  };

  static Color fromMeasurement(Measurement m, int age, {String gender = 'male'}) {
    final engine = ThresholdEngine.instance;
    if (m.type == MeasurementType.bloodPressure) {
      final stage = engine.evaluateBPStage(
        systolic: m.value1.toInt(),
        diastolic: (m.value2 ?? 0).toInt(),
        age: age,
        gender: gender,
      );
      return fromBPStage(stage);
    }
    final stage = engine.evaluateSugarStage(
      value: m.value1,
      isFasting: m.isFasting ?? true,
    );
    return fromSugarStage(stage);
  }

  static bool isExceeded(Measurement m, int age, {String gender = 'male'}) {
    final engine = ThresholdEngine.instance;
    if (m.type == MeasurementType.bloodPressure) {
      final stage = engine.evaluateBPStage(
        systolic: m.value1.toInt(),
        diastolic: (m.value2 ?? 0).toInt(),
        age: age,
        gender: gender,
      );
      return stage != BloodPressureStage.normal &&
          stage != BloodPressureStage.hypotension;
    }
    final stage = engine.evaluateSugarStage(
      value: m.value1,
      isFasting: m.isFasting ?? true,
    );
    return stage != BloodSugarStage.normal &&
        stage != BloodSugarStage.hypoglycemia;
  }

  static String labelOf(Measurement m, int age, {String gender = 'male'}) {
    final engine = ThresholdEngine.instance;
    if (m.type == MeasurementType.bloodPressure) {
      return engine
          .evaluateBPStage(
            systolic: m.value1.toInt(),
            diastolic: (m.value2 ?? 0).toInt(),
            age: age,
            gender: gender,
          )
          .label;
    }
    return engine
        .evaluateSugarStage(
          value: m.value1,
          isFasting: m.isFasting ?? true,
        )
        .label;
  }
}
