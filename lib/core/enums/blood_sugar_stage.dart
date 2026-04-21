// Kan şekeri klinik evrelerini tanımlayan enum.
// Hipoglisemi'den Diyabet'e kadar 4 evre içerir.

enum BloodSugarStage {
  hypoglycemia,
  normal,
  prediabetes,
  diabetes,
}

extension BloodSugarStageX on BloodSugarStage {
  String get label => switch (this) {
    BloodSugarStage.hypoglycemia => 'Hipoglisemi',
    BloodSugarStage.normal => 'Normal',
    BloodSugarStage.prediabetes => 'Prediyabet',
    BloodSugarStage.diabetes => 'Diyabet',
  };
}
