// Analiz ekranında seçilebilecek kategorileri tanımlayan enum.
// Büyük tansiyon, küçük tansiyon, açlık ve tokluk şekeri.

import '../constants/app_texts.dart';

enum AnalysisCategory { systolic, diastolic, fasting, postMeal }

extension AnalysisCategoryX on AnalysisCategory {
  String get label {
    return switch (this) {
      AnalysisCategory.systolic => AppTexts.categoryBigBP,
      AnalysisCategory.diastolic => AppTexts.categorySmallBP,
      AnalysisCategory.fasting => AppTexts.categoryFasting,
      AnalysisCategory.postMeal => AppTexts.categoryPostMeal,
    };
  }

  String get unit {
    return switch (this) {
      AnalysisCategory.systolic => 'mmHg',
      AnalysisCategory.diastolic => 'mmHg',
      AnalysisCategory.fasting => 'mg/dL',
      AnalysisCategory.postMeal => 'mg/dL',
    };
  }

  bool get isBloodPressure =>
      this == AnalysisCategory.systolic || this == AnalysisCategory.diastolic;
}
