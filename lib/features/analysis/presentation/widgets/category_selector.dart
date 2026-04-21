import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final AnalysisCategory selected;
  final ValueChanged<AnalysisCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  AppTexts.groupBloodPressure,
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontSM(context),
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  AppTexts.groupSugar,
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontSM(context),
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
          child: Row(
            children: [
              CategoryChip(
                category: AnalysisCategory.systolic,
                label: AppTexts.categoryBigBP,
                selected: selected == AnalysisCategory.systolic,
                onTap: () => onChanged(AnalysisCategory.systolic),
              ),
              SizedBox(width: AppDimensions.spacingXS(context)),
              CategoryChip(
                category: AnalysisCategory.diastolic,
                label: AppTexts.categorySmallBP,
                selected: selected == AnalysisCategory.diastolic,
                onTap: () => onChanged(AnalysisCategory.diastolic),
              ),
              Container(
                width: 1,
                height: AppDimensions.spacingXL(context),
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
                color: AppColors.divider,
              ),
              CategoryChip(
                category: AnalysisCategory.fasting,
                label: AppTexts.categoryFasting,
                selected: selected == AnalysisCategory.fasting,
                onTap: () => onChanged(AnalysisCategory.fasting),
              ),
              SizedBox(width: AppDimensions.spacingXS(context)),
              CategoryChip(
                category: AnalysisCategory.postMeal,
                label: AppTexts.categoryPostMeal,
                selected: selected == AnalysisCategory.postMeal,
                onTap: () => onChanged(AnalysisCategory.postMeal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
