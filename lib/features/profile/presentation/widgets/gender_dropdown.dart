import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.validator,
  });

  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: AppTexts.genderLabel,
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
        prefixIcon: Icon(
          Icons.person_outline,
          color: AppColors.primary,
          size: AppDimensions.iconMD(context),
        ),
      ),
      style: GoogleFonts.nunito(color: AppColors.textPrimary),
      items: const [
        DropdownMenuItem(value: AppTexts.genderMaleValue, child: Text(AppTexts.genderMale)),
        DropdownMenuItem(value: AppTexts.genderFemaleValue, child: Text(AppTexts.genderFemale)),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
