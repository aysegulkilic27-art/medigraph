// Profil bilgisi giriş formu. Ad, doğum tarihi, boy, kilo ve cinsiyet alanları.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_constants.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/profile/presentation/widgets/gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
    required this.nameController,
    required this.selectedBirthDate,
    required this.onBirthDateChanged,
    required this.heightController,
    required this.weightController,
    required this.gender,
    required this.onGenderChanged,
    required this.birthDateValidator,
    required this.heightValidator,
    required this.weightValidator,
    required this.genderValidator,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController nameController;
  final DateTime? selectedBirthDate;
  final ValueChanged<DateTime?> onBirthDateChanged;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final String? gender;
  final ValueChanged<String?> onGenderChanged;
  final String? Function(DateTime?) birthDateValidator;
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
        _BirthDatePickerField(
          selectedDate: selectedBirthDate,
          label: AppTexts.birthDateLabel,
          icon: Icons.calendar_today_outlined,
          validator: birthDateValidator,
          onDateChanged: onBirthDateChanged,
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

class _BirthDatePickerField extends StatelessWidget {
  const _BirthDatePickerField({
    required this.selectedDate,
    required this.label,
    required this.icon,
    required this.validator,
    required this.onDateChanged,
  });

  final DateTime? selectedDate;
  final String label;
  final IconData icon;
  final String? Function(DateTime?) validator;
  final ValueChanged<DateTime?> onDateChanged;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat(AppConstants.dateFormatFull);
    final formattedDate = selectedDate != null ? dateFormat.format(selectedDate!) : '';
    
    return FormField<DateTime>(
      validator: (value) => validator(value),
      builder: (FormFieldState<DateTime> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime(DateTime.now().year - 30),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  onDateChanged(picked);
                  state.didChange(picked);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingMD(context),
                  vertical: AppDimensions.spacingSM(context),
                ),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(AppDimensions.inputRadius(context)),
                  border: Border.all(
                    color: state.hasError ? Colors.red : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: AppColors.primary),
                    SizedBox(width: AppDimensions.spacingSM(context)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: GoogleFonts.nunito(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            formattedDate.isNotEmpty ? formattedDate : 'Tarih seçin',
                            style: GoogleFonts.nunito(
                              color: formattedDate.isNotEmpty
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(top: AppDimensions.spacingXS(context)),
                child: Text(
                  state.errorText ?? '',
                  style: GoogleFonts.nunito(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

