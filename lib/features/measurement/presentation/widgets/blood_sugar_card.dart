// Kan şekeri ölçümü giriş formu. Değer alanı, açlık/tokluk
// seçimi, not girişi ve kaydet butonu içerir.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/measurement/presentation/widgets/fasting_toggle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BloodSugarCard extends StatelessWidget {
  const BloodSugarCard({
    super.key,
    required this.sugarController,
    required this.noteController,
    required this.isFasting,
    required this.onFastingChanged,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController sugarController;
  final TextEditingController noteController;
  final bool isFasting;
  final ValueChanged<bool> onFastingChanged;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.sugarGradientStart, AppColors.sugarGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.cardRadius(context) + AppDimensions.spacingXS(context),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sugarGradientStart.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          AppDimensions.cardPadding(context) + AppDimensions.spacingXS(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: Colors.white,
                  size: AppDimensions.iconMD(context),
                ),
                SizedBox(width: AppDimensions.spacingSM(context)),
                Text(
                  AppTexts.bloodSugar,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: AppDimensions.fontLG(context) + AppDimensions.spacingXS(context) / 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spacingMD(context)),
            _WhiteInput(label: AppTexts.sugarLabel, controller: sugarController),
            SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
            FastingToggle(isFasting: isFasting, onChanged: onFastingChanged),
            SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2),
            TextField(
              controller: noteController,
              maxLines: 2,
              maxLength: 200,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: AppDimensions.fontSM(context) + AppDimensions.spacingXS(context) / 4,
              ),
              decoration: InputDecoration(
                hintText: AppTexts.noteHint,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: AppDimensions.fontSM(context) + AppDimensions.spacingXS(context) / 4,
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 1.5,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.notes_rounded,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 18,
                ),
                counterStyle: GoogleFonts.nunito(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: AppDimensions.fontXS(context),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context),
                  vertical: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.accentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.inputRadius(context)),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) + AppDimensions.spacingXS(context) / 2,
                  ),
                ),
                onPressed: isSaving ? null : onSave,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: isSaving ? 0.96 : 1,
                  child: Text(
                    isSaving ? AppTexts.saving : AppTexts.saveButton,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhiteInput extends StatelessWidget {
  const _WhiteInput({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.spaceMono(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.nunito(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius(context)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

