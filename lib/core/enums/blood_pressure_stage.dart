// Kan basıncı klinik evrelerini tanımlayan enum.
// Hipotansiyon'dan Kriz'e kadar 6 evre içerir.

enum BloodPressureStage {
  hypotension,
  normal,
  elevated,
  stage1,
  stage2,
  crisis,
}

extension BloodPressureStageX on BloodPressureStage {
  String get label => switch (this) {
    BloodPressureStage.hypotension => 'Düşük',
    BloodPressureStage.normal => 'Normal',
    BloodPressureStage.elevated => 'Yüksek Normal',
    BloodPressureStage.stage1 => 'Evre 1',
    BloodPressureStage.stage2 => 'Evre 2',
    BloodPressureStage.crisis => 'Kriz',
  };
}
