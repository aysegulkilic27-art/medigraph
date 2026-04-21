// Ölçüm listesinde tek bir kaydı gösteren satır widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/core/utils/date_utils.dart';
import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeasurementListItem extends StatelessWidget {
  const MeasurementListItem({super.key, required this.measurement});

  final Measurement measurement;

  @override
  Widget build(BuildContext context) {
    final statusColor = StageColorResolver.fromMeasurement(measurement, 30);
    final isHigh = StageColorResolver.isExceeded(measurement, 30);

    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.spacingSM(context)),
      padding: EdgeInsets.all(
        AppDimensions.cardPadding(context) - AppDimensions.spacingXS(context) / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(
          AppDimensions.cardRadius(context) - AppDimensions.spacingXS(context) / 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: AppDimensions.statCardHeight(context) / 2,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(AppDimensions.spacingXS(context) / 2),
            ),
          ),
          SizedBox(width: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
          Container(
            padding: EdgeInsets.all(AppDimensions.spacingSM(context)),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
              ),
            ),
            child: Icon(
              measurement.type == MeasurementType.bloodPressure
                  ? Icons.favorite
                  : Icons.water_drop,
              color: statusColor,
              size: AppDimensions.iconMD(context) - AppDimensions.spacingXS(context) / 2,
            ),
          ),
          SizedBox(width: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  measurement.type == MeasurementType.bloodPressure
                      ? '${measurement.value1.toInt()}/${measurement.value2?.toInt()} ${AppTexts.mmHg}'
                      : '${measurement.value1.toStringAsFixed(1)} ${AppTexts.mgDl}',
                  style: GoogleFonts.spaceMono(
                    fontSize: AppDimensions.fontLG(context),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  AppDateUtils.formatDateTime(measurement.dateTime),
                  style: GoogleFonts.nunito(
                    fontSize: AppDimensions.fontSM(context),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isHigh)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingSM(context),
                vertical: AppDimensions.spacingXS(context),
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.spacingSM(context)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.accent,
                    size: AppDimensions.iconSM(context) - AppDimensions.spacingXS(context) / 2,
                  ),
                  SizedBox(width: AppDimensions.spacingXS(context)),
                  Text(
                    AppTexts.legendHigh,
                    style: GoogleFonts.nunito(
                      color: AppColors.accent,
                      fontSize: AppDimensions.fontXS(context) + AppDimensions.spacingXS(context) / 4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
