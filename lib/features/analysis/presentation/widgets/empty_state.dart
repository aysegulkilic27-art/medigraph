import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalysisEmptyState extends StatelessWidget {
  const AnalysisEmptyState({super.key, required this.category});

  final AnalysisCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.chartHeight(context),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            category.isBloodPressure ? Icons.favorite_border : Icons.water_drop_outlined,
            color: AppColors.primary.withValues(alpha: 0.3),
            size: AppDimensions.iconLG(context) + AppDimensions.spacingXS(context),
          ),
          SizedBox(height: AppDimensions.spacingSM(context)),
          Text(
            AppTexts.noDataInCategory,
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSM(context),
            ),
          ),
        ],
      ),
    );
  }
}
