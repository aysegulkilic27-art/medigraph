// Profil bilgisi giriş formu. Ad, yaş, boy, kilo ve cinsiyet alanları.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/profile/presentation/widgets/gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.gender,
    required this.onGenderChanged,
    required this.ageValidator,
    required this.heightValidator,
    required this.weightValidator,
    required this.genderValidator,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final String? gender;
  final ValueChanged<String?> onGenderChanged;
  final String? Function(String?) ageValidator;
  final String? Function(String?) heightValidator;
  final String? Function(String?) weightValidator;
  final String? Function(String?) genderValidator;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        0,
        AppDimensions.spacingMD(context) + AppDimensions.spacingXS(context),
        0,
        100,
      ),
      children: [
        _ProfileField(
          controller: nameController,
          label: AppTexts.nameLabel,
          icon: Icons.badge_outlined,
        ),
        SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
        _ProfileField(
          controller: ageController,
          label: AppTexts.ageLabel,
          icon: Icons.cake_outlined,
          keyboardType: TextInputType.number,
          validator: ageValidator,
        ),
        SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
        _ProfileField(
          controller: heightController,
          label: AppTexts.heightLabel,
          icon: Icons.height,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: heightValidator,
        ),
        SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
        _ProfileField(
          controller: weightController,
          label: AppTexts.weightLabel,
          icon: Icons.monitor_weight_outlined,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: weightValidator,
        ),
        SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
        GenderDropdown(
          value: gender,
          onChanged: onGenderChanged,
          validator: genderValidator,
        ),
        SizedBox(height: AppDimensions.spacingMD(context) + AppDimensions.spacingXS(context)),
        SizedBox(
          width: double.infinity,
          height: AppDimensions.inputHeight(context),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              shadowColor: AppColors.primary.withValues(alpha: 0.4),
            ),
            onPressed: isSaving ? null : onSave,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 180),
              scale: isSaving ? 0.96 : 1,
              child: Text(
                isSaving ? AppTexts.saving : AppTexts.saveButton,
                style: GoogleFonts.poppins(
                  fontSize: AppDimensions.fontLG(context),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.nunito(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.nunito(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius(context)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius(context)),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        prefixIcon: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}

