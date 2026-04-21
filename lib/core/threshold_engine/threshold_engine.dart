// Kan basıncı ve kan şekeri ölçümlerini klinik evrelere göre
// sınıflandıran motor. AHA 2017 ve WHO/ADA kriterlerini uygular.
// Singleton pattern ile kullanılır: ThresholdEngine.instance

import 'package:diyabetansiyon/core/enums/blood_pressure_stage.dart';
import 'package:diyabetansiyon/core/enums/blood_sugar_stage.dart';
import 'package:diyabetansiyon/core/threshold_engine/models/pediatric_bp_table.dart';

class ThresholdEngine {
  ThresholdEngine._internal();
  static final ThresholdEngine instance = ThresholdEngine._internal();

  BloodPressureStage evaluateBPStage({
    required int systolic,
    required int diastolic,
    required int age,
    String gender = 'male',
  }) {
    if (age < 18) {
      return _evaluatePediatricBP(systolic, diastolic, age, gender == 'male');
    }
    return _evaluateAdultBP(systolic, diastolic);
  }

  BloodPressureStage _evaluateAdultBP(int sys, int dia) {
    if (sys > 180 || dia > 120) return BloodPressureStage.crisis;
    if (sys < 90 || dia < 60) return BloodPressureStage.hypotension;
    if (sys < 120 && dia < 80) return BloodPressureStage.normal;
    if (sys < 130 && dia < 80) return BloodPressureStage.elevated;
    if (sys < 140 && dia < 90) return BloodPressureStage.stage1;
    return BloodPressureStage.stage2;
  }

  BloodPressureStage _evaluatePediatricBP(
    int sys,
    int dia,
    int age,
    bool isMale,
  ) {
    final entry = getPediatricEntry(age, isMale);
    if (entry == null) return _evaluateAdultBP(sys, dia);

    if (sys < (entry.sys50p - 10) || dia < (entry.dia50p - 10)) {
      return BloodPressureStage.hypotension;
    }
    if (sys < entry.sys50p && dia < entry.dia50p) {
      return BloodPressureStage.normal;
    }
    if (sys < entry.sys95p && dia < entry.dia95p) {
      return BloodPressureStage.elevated;
    }
    if (sys < entry.sys95p + 12 && dia < entry.dia95p + 10) {
      return BloodPressureStage.stage1;
    }
    return BloodPressureStage.stage2;
  }

  BloodSugarStage evaluateSugarStage({
    required double value,
    required bool isFasting,
  }) {
    if (isFasting) {
      if (value < 70) return BloodSugarStage.hypoglycemia;
      if (value < 100) return BloodSugarStage.normal;
      if (value < 126) return BloodSugarStage.prediabetes;
      return BloodSugarStage.diabetes;
    }

    if (value < 70) return BloodSugarStage.hypoglycemia;
    if (value < 140) return BloodSugarStage.normal;
    if (value < 200) return BloodSugarStage.prediabetes;
    return BloodSugarStage.diabetes;
  }
}
