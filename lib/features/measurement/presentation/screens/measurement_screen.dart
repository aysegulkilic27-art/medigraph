// Tansiyon ve kan şekeri ölçümü girişi yapılan ana ekran.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/core/widgets/gradient_app_bar.dart';
import 'package:diyabetansiyon/core/widgets/health_background.dart';
import 'package:diyabetansiyon/features/measurement/presentation/providers/measurement_provider.dart';
import 'package:diyabetansiyon/features/measurement/presentation/widgets/blood_pressure_card.dart';
import 'package:diyabetansiyon/features/measurement/presentation/widgets/blood_sugar_card.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MeasurementScreen extends ConsumerStatefulWidget {
  const MeasurementScreen({super.key});

  @override
  ConsumerState<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends ConsumerState<MeasurementScreen> {
  final _sysController = TextEditingController();
  final _diaController = TextEditingController();
  final _sugarController = TextEditingController();
  final _bpNoteController = TextEditingController();
  final _sugarNoteController = TextEditingController();
  bool _isFasting = true;
  bool _savingPressure = false;
  bool _savingSugar = false;

  @override
  void dispose() {
    _sysController.dispose();
    _diaController.dispose();
    _sugarController.dispose();
    _bpNoteController.dispose();
    _sugarNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GradientAppBar(title: AppTexts.measurementTitle),
      body: HealthBackground(
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              AppDimensions.spacingMD(context) + AppDimensions.spacingXS(context),
              0,
              AppDimensions.spacingMD(context) + AppDimensions.spacingXS(context),
              100,
            ),
            child: Column(
              children: [
                SizedBox(
                  height:
                      AppDimensions.spacingLG(context) - AppDimensions.spacingXS(context),
                ),
                BloodPressureCard(
                  systolicController: _sysController,
                  diastolicController: _diaController,
                  noteController: _bpNoteController,
                  isSaving: _savingPressure,
                  onSave: _savePressure,
                ),
                SizedBox(height: AppDimensions.spacingMD(context)),
                BloodSugarCard(
                  sugarController: _sugarController,
                  noteController: _sugarNoteController,
                  isFasting: _isFasting,
                  onFastingChanged: (value) => setState(() => _isFasting = value),
                  isSaving: _savingSugar,
                  onSave: _saveSugar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _savePressure() async {
    final sys = double.tryParse(_sysController.text.trim());
    final dia = double.tryParse(_diaController.text.trim());
    if (sys == null || sys < 60 || sys > 300) {
      _showMeasurementSnackBar(AppTexts.invalidSystolic, AppColors.statusHigh);
      return;
    }
    if (dia == null || dia < 40 || dia > 300) {
      _showMeasurementSnackBar(AppTexts.invalidDiastolic, AppColors.statusHigh);
      return;
    }

    setState(() => _savingPressure = true);
    try {
      final useCase = ref.read(addMeasurementUseCaseProvider);
      final activeProfile = ref.read(activeProfileProvider);
      final note = _bpNoteController.text.trim().isEmpty
          ? null
          : _bpNoteController.text.trim();
      await useCase.execute(
        type: MeasurementType.bloodPressure,
        value1: sys,
        value2: dia,
        note: note,
        profileId: activeProfile?.id,
      );

      ref.invalidate(allMeasurementsProvider);
      final latest = await ref.read(allMeasurementsProvider.future);
      _debugPrintLatestNotes(latest);
      final profile = await ref.read(profileProvider.future);
      final age = profile?.age ?? 30;
      final isHigh = latest.isNotEmpty && StageColorResolver.isExceeded(latest.first, age);
      if (!mounted) return;
      _sysController.clear();
      _diaController.clear();
      _bpNoteController.clear();
      _showMeasurementSnackBar(
        AppTexts.bpSaved,
        isHigh ? AppColors.accent : AppColors.statusNormal,
      );
    } finally {
      if (mounted) {
        setState(() => _savingPressure = false);
      }
    }
  }

  Future<void> _saveSugar() async {
    final sugar = double.tryParse(_sugarController.text);
    if (sugar == null) {
      _showMeasurementSnackBar(AppTexts.invalidSugar, AppColors.statusHigh);
      return;
    }

    setState(() => _savingSugar = true);
    try {
      final useCase = ref.read(addMeasurementUseCaseProvider);
      final activeProfile = ref.read(activeProfileProvider);
      final note = _sugarNoteController.text.trim().isEmpty
          ? null
          : _sugarNoteController.text.trim();
      await useCase.execute(
        type: MeasurementType.bloodSugar,
        value1: sugar,
        isFasting: _isFasting,
        note: note,
        profileId: activeProfile?.id,
      );

      ref.invalidate(allMeasurementsProvider);
      final latest = await ref.read(allMeasurementsProvider.future);
      _debugPrintLatestNotes(latest);
      final profile = await ref.read(profileProvider.future);
      final age = profile?.age ?? 30;
      final isHigh = latest.isNotEmpty && StageColorResolver.isExceeded(latest.first, age);
      if (!mounted) return;
      setState(() {
        _sugarController.clear();
        _sugarNoteController.clear();
        _isFasting = true;
      });
      _showMeasurementSnackBar(
        AppTexts.sugarSaved,
        isHigh ? AppColors.accent : AppColors.statusNormal,
      );
    } finally {
      if (mounted) {
        setState(() => _savingSugar = false);
      }
    }
  }

  void _showMeasurementSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius(context)),
        ),
      ),
    );
  }

  void _debugPrintLatestNotes(List<dynamic> measurements) {
    debugPrint('=== HIVE NOTES DEBUG (latest 5) ===');
    for (final m in measurements.take(5)) {
      final note = _readNote(m);
      final type = _readType(m);
      final time = _readDateTime(m);
      debugPrint('type=$type time=$time note=${note ?? "null"}');
    }
    debugPrint('=== /HIVE NOTES DEBUG ===');
  }

  String? _readNote(dynamic measurement) {
    try {
      final dynamic note = measurement.note;
      if (note is String && note.trim().isNotEmpty) {
        return note.trim();
      }
    } catch (_) {}
    return null;
  }

  String _readType(dynamic measurement) {
    try {
      final dynamic type = measurement.type;
      return type.toString();
    } catch (_) {
      return 'unknown';
    }
  }

  String _readDateTime(dynamic measurement) {
    try {
      final dynamic dateTime = measurement.dateTime;
      return dateTime.toString();
    } catch (_) {
      return 'unknown';
    }
  }
}
