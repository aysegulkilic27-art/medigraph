// Uygulamada görüntülenen tüm metin sabitleri.
// Lokalizasyon altyapısı için tek kaynak noktası.

class AppTexts {
  AppTexts._();

  // Validation
  static const invalidSugar = 'Lütfen geçerli şeker değeri girin.';
  static const invalidSystolic =
      'Büyük tansiyon 60-300 mmHg aralığında olmalıdır.';
  static const invalidDiastolic =
      'Küçük tansiyon 40-300 mmHg aralığında olmalıdır.';
  static const invalidPressure = 'Lütfen geçerli tansiyon değeri girin.';
  static const invalidBPSystolic =
      'Lütfen geçerli büyük tansiyon değeri girin.';
  static const invalidBPDiastolic =
      'Lütfen geçerli küçük tansiyon değeri girin.';
  static const invalidBPGeneral = 'Lütfen geçerli tansiyon değeri girin.';
  static const invalidProfile = 'Geçersiz profil bilgisi';
  static const invalidAge = 'Lütfen geçerli doğum tarihi seçin.';
  static const invalidHeight = 'Lütfen geçerli boy girin.';
  static const invalidWeight = 'Lütfen geçerli kilo girin.';
  static const requiredField = 'Bu alan zorunludur.';

  // Feedback
  static const sugarSaved = 'Şeker ölçümü kaydedildi.';
  static const bpSaved = 'Tansiyon ölçümü kaydedildi.';
  static const profileSaved = 'Profil kaydedildi.';
  static const dataDeleted = 'Tüm veriler silindi.';

  // Measurement
  static const measurementTitle = 'Ölçüm Girişi';
  static const bloodPressure = 'Tansiyon';
  static const bloodSugar = 'Şeker';
  static const systolicLabel = 'Büyük Tansiyon (mmHg)';
  static const diastolicLabel = 'Küçük Tansiyon (mmHg)';
  static const sugarLabel = 'Değer (mg/dL)';
  static const fasting = 'Açlık';
  static const postMeal = 'Tokluk';
  static const fastingToggle = 'Açlık/Tokluk';
  static const saveButton = 'Kaydet';
  static const saving = 'Kaydediliyor...';
  static const noteHint = 'Not ekle (opsiyonel)';
    static const systolicHint = 'Büyük Tansiyon (orn: 150 mmHg)';
    static const diastolicHint = 'Küçük Tansiyon (orn: 70 mmHg)';
  static const recentMeasurements = 'Son Ölçümler';
  static const noMeasurements = 'Henüz ölçüm yok.';
  static const firstMeasurementHint =
      'İlk ölçümü ekleyerek takibe başlayabilirsiniz.';
  static const startTracking = 'İlk ölçümü ekleyerek takibe başlayabilirsiniz.';

  // Analysis
  static const analysisTitle = 'Analiz';
  static const tabDaily = 'Günlük';
  static const tabWeekly = 'Haftalık';
  static const tabMonthly = 'Aylık';
  static const tabThreeMonths = '3 Aylık';
  static const categoryBigBP = 'Büyük';
  static const categorySmallBP = 'Küçük';
  static const categoryFasting = 'Açlık';
  static const categoryPostMeal = 'Tokluk';
  static const groupBloodPressure = 'Tansiyon';
  static const groupSugar = 'Şeker';
  static const statTotal = 'Toplam';
  static const statExceeded = 'Eşik Aşımı';
  static const statAverage = 'Ortalama';
  static const legendNormal = 'Normal';
  static const legendHigh = 'Yüksek';
  static const legendLow = 'Düşük';
  static const noDataInCategory = 'Bu kategoride ölçüm yok';
  static const mmHg = 'mmHg';
  static const mgDl = 'mg/dL';

  // Common
  static const measurementsSection = 'Ölçümler';
  static const settingsTitle = 'Ayarlar';
  static const settingsAgeBanner =
      'Boy ve kilo bilgisi değişiklikleri ilerleyen ölçümlerinizdeki eşik değer hesabında kullanılır. Lütfen bilgilerinizi güncel tutun.';
  static const ageWarningText =
      'Boy ve kilo bilgisi değişimleri ilerleyen ölçümlerinizdeki eşik değer hesabında kullanılır. Lütfen bilgilerinizi güncel tutun.';
  static const updateProfile = 'Profili Güncelle';
  static const updateProfileSub = 'Mevcut profili düzenle';
  static const pdfReport = 'PDF Rapor Al';
  static const pdfReportSub = 'Dönem seçerek verilerinizi dışa aktarın';
  static const clinicalReferencesTitle = 'Kullanılan Klinik Referanslar';
  static const clinicalReferencesSub =
      'Bu uygulamadaki otomatik sınıflandırma aşağıdaki rehberleri temel alır.';
  static const clinicalRefAha = 'Yetişkin tansiyon: AHA 2017';
  static const clinicalRefWhoAda = 'Kan şekeri sınıflaması: WHO/ADA';
  static const clinicalRefAap = 'Çocuk-ergen tansiyon: AAP 2017';
  static const clinicalReferencesNote =
      'Bilgilendirme amaçlıdır; tanı ve tedavi için hekim değerlendirmesi gerekir.';
  static const deleteData = 'Verilerimi Sil';
  static const deleteConfirmTitle = 'Emin misiniz?';
  static const deleteConfirmBody =
      'Tüm ölçüm verileriniz kalıcı olarak silinecek.';
  static const deleteError = 'Veriler silinemedi, tekrar deneyin';
  static const confirmYes = 'Evet, Sil';
  static const confirmNo = 'İptal';
  static const noProfile = 'Profil yok';

  // Profile
  static const profileTitle = 'Profil';
  static const updateProfileTitle = 'Profili Güncelle';
  static const nameLabel = 'Ad (Opsiyonel)';
  static const birthDateLabel = 'Doğum Tarihi';
  static const heightLabel = 'Boy (cm)';
  static const weightLabel = 'Kilo (kg)';
  static const genderLabel = 'Cinsiyet';
  static const genderMale = 'Erkek';
  static const genderFemale = 'Kadın';
  static const genderRequired = 'Lütfen cinsiyet seçin.';
  static const genderMaleValue = 'male';
  static const genderFemaleValue = 'female';

  // App
  static const homeRoute = '/home';
  static const appName = 'DiyabeTansiyon';
  static const appStartError =
      'Uygulama başlatılamadı.\nLütfen uygulamayı yeniden kurun.';

  // Formats
  static const dateTimeFormat = 'dd.MM.yyyy HH:mm';
  static const dateFormat = 'dd.MM.yyyy';
  static const dateTimeFormatShort = 'dd/MM';

  // Navigation
  static const navMeasurement = 'Ölçüm';
  static const navAnalysis = 'Analiz';
  static const navRecords = 'Tüm Ölçümler';
  static const navSettings = 'Ayarlar';

  // Records
  static const recordsTitle = 'Tüm Ölçümler';
  static const notesTabBP = 'Tansiyon';
  static const notesTabSugar = 'Şeker';

  // Stages
  static const stageLow = 'Düşük';
  static const stageNormal = 'Normal';
  static const stageElevated = 'Yüksek Normal';
  static const stageStage1 = 'Evre 1';
  static const stageStage2 = 'Evre 2';
  static const stageCrisis = 'Kriz';
  static const stageHypo = 'Hipoglisemi';
  static const stagePrediabet = 'Prediyabet';
  static const stageDiabet = 'Diyabet';

  // Report Period Sheet
  static const reportPeriodTitle = 'Rapor Dönemi Seçin';
  static const reportGenerating = 'Hazırlanıyor...';
  static const reportGenerate = 'Rapor Al';
  static const reportDateError = 'Lütfen geçerli bir tarih aralığı seçin.';
  static const reportError = 'Rapor oluşturulamadı';
  static const periodWeek = 'Son 1 Hafta';
  static const periodMonth = 'Son 1 Ay';
  static const periodThreeMonths = 'Son 3 Ay';
  static const periodCustom = 'Özel Aralık';

  // PDF
  static const pdfNoData = 'Veri yok';
  static const pdfReportTitle = 'Sağlık Takip Raporu';
  static const pdfAppName = 'Sağlık\nTakip';
  static const pdfFooterDisclaimer =
      'Bu rapor otomatik oluşturulmuştur. Hekimler dışında tanı amacı ile kullanılamaz.';
  static const pdfPatientInfo = 'Hasta Bilgileri';
  static const pdfReportPeriod = 'Rapor Dönemi';
  static const pdfGeneralSummary = 'Genel Özet';
  static const pdfBPMeasurement = 'Tansiyon\nÖlçümü';
  static const pdfBPExceeded = 'Tansiyon\nEşik Aşımı';
  static const pdfSugarMeasurement = 'Şeker\nÖlçümü';
  static const pdfSugarExceeded = 'Şeker\nEşik Aşımı';
  static const pdfBPAverages = 'Tansiyon Ortalamaları';
  static const pdfSugarAverages = 'Şeker Ortalamaları';
  static const pdfSystolicAvg = 'Büyük Tansiyon';
  static const pdfDiastolicAvg = 'Küçük Tansiyon';
  static const pdfFastingSugarAvg = 'Açlık Şekeri';
  static const pdfPostMealSugarAvg = 'Tokluk Şekeri';
  static const pdfBPReport = 'Tansiyon Raporu';
    static const pdfBPTrendCombined = 'Tansiyon Trend Grafiği';
    static const pdfLegendTitle = 'Renk Kodları';
    static const pdfSystolicLine = 'Büyük';
    static const pdfDiastolicLine = 'Küçük';
  static const pdfSystolicTrend = 'Büyük Tansiyon Trendi';
  static const pdfDiastolicTrend = 'Küçük Tansiyon Trendi';
  static const pdfMeasurementDetails = 'Ölçüm Detayları';
  static const pdfNoRecords = 'Bu dönem için kayıt bulunamadı.';
  static const pdfSugarReport = 'Şeker Raporu';
  static const pdfFastingTrend = 'Açlık Şekeri Trendi';
  static const pdfPostMealTrend = 'Tokluk Şekeri Trendi';
  static const pdfNoSugar = 'Bu dönem için Şeker Ölçümü bulunamadı.';
  static const pdfShowingLast = 'Son 30 kayıt gösteriliyor (Toplam:';
  static const pdfFileName = 'saglik_raporu_';

  static const errorPrefix = 'Hata';
}
