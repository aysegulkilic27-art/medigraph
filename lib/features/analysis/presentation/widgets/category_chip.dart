// Analiz kategorisi seçimi için kullanılan chip widget'ı.

import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final AnalysisCategory category;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isBloodPressure = category.isBloodPressure;
    final activeColor = isBloodPressure ? AppColors.primary : AppColors.chipSugarEnd;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
          ),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    colors: isBloodPressure
                        ? [AppColors.chipBPStart, AppColors.chipBPEnd]
                        : [AppColors.chipSugarStart, AppColors.chipSugarEnd],
                  )
                : null,
            color: selected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(
              AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isBloodPressure ? Icons.favorite : Icons.water_drop,
                size: AppDimensions.iconSM(context) - AppDimensions.spacingXS(context) / 2,
                color: selected
                    ? Colors.white
                    : activeColor.withValues(alpha: 0.5),
              ),
              SizedBox(height: AppDimensions.spacingXS(context) / 2),
              Text(
                label,
                style: GoogleFonts.nunito(
                  fontSize: AppDimensions.fontXS(context) + AppDimensions.spacingXS(context) / 4,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
