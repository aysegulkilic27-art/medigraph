import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          AppDimensions.cardPadding(context) + AppDimensions.spacingXS(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconLG(context) * 2,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
            SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontLG(context) + AppDimensions.spacingXS(context) / 2,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppDimensions.spacingXS(context)),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: AppColors.textSecondary,
                fontSize: AppDimensions.fontSM(context) + AppDimensions.spacingXS(context) / 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
