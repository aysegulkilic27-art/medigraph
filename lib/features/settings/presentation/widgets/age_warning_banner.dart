// Yaş bilgisinin eşik hesabında kullanıldığını bildiren
// sarı uyarı banner widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgeWarningBanner extends StatelessWidget {
  const AgeWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppDimensions.cardPadding(context) -
            AppDimensions.spacingXS(context) / 2,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.bannerStart, AppColors.bannerEnd],
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.cardRadius(context) -
              AppDimensions.spacingXS(context) / 2,
        ),
        border: Border.all(
          color: AppColors.bannerBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.bannerIcon,
            size: AppDimensions.iconMD(context),
          ),
          SizedBox(
            width:
                AppDimensions.spacingSM(context) +
                AppDimensions.spacingXS(context) / 2,
          ),
          Expanded(
            child: Text(
              AppTexts.bodyWarningBanner,
              style: GoogleFonts.nunito(
                color: AppColors.bannerText,
                fontSize:
                    AppDimensions.fontSM(context) +
                    AppDimensions.spacingXS(context) / 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
