import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClinicalReferencesCard extends StatelessWidget {
  const ClinicalReferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final radius =
        AppDimensions.cardRadius(context) -
        AppDimensions.spacingXS(context) / 2;

    return Container(
      padding: EdgeInsets.all(AppDimensions.cardPadding(context)),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.menu_book_rounded,
                color: AppColors.primary,
                size: AppDimensions.iconMD(context),
              ),
              SizedBox(width: AppDimensions.spacingSM(context)),
              Expanded(
                child: Text(
                  AppTexts.clinicalReferencesTitle,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: AppDimensions.fontMD(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingSM(context)),
          Text(
            AppTexts.clinicalReferencesSub,
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSM(context),
            ),
          ),
          SizedBox(height: AppDimensions.spacingSM(context)),
          _RefLine(text: AppTexts.clinicalRefAha),
          _RefLine(text: AppTexts.clinicalRefWhoAda),
          _RefLine(text: AppTexts.clinicalRefAap),
          SizedBox(height: AppDimensions.spacingSM(context)),
          Text(
            AppTexts.clinicalReferencesNote,
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSM(context),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RefLine extends StatelessWidget {
  const _RefLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.spacingXS(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppDimensions.spacingXS(context)),
            child: Icon(
              Icons.circle,
              size: AppDimensions.spacingXS(context) + 3,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: AppDimensions.spacingSM(context)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.nunito(
                color: AppColors.textPrimary,
                fontSize: AppDimensions.fontSM(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
