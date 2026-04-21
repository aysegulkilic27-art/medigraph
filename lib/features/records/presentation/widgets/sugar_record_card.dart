// Kan şekeri kaydını stage badge, açlık/tokluk etiketi ve
// not ile gösteren kart widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:diyabetansiyon/features/records/presentation/utils/card_color_resolver.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SugarRecordCard extends StatelessWidget {
  const SugarRecordCard({required this.measurement, required this.age, super.key});

  final Measurement measurement;
  final int age;

  @override
  Widget build(BuildContext context) {
    final cardColor = CardColorResolver.resolve(measurement, age);
    final note = _readNote(measurement);
    final hasNote = note != null && note.isNotEmpty;
    final label = measurement.isFasting == true
        ? AppTexts.fasting
        : AppTexts.postMeal;

    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.cardPadding(context),
        vertical: AppDimensions.cardPadding(context) - AppDimensions.spacingXS(context) / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppDimensions.cardRadius(context) - AppDimensions.spacingXS(context) / 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${measurement.value1} ${AppTexts.mgDl}',
                  style: GoogleFonts.spaceMono(
                    fontSize: AppDimensions.fontMD(context) + AppDimensions.spacingXS(context) / 4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacingXS(context) / 2),
                _StageBadge(
                  label: StageColorResolver.labelOf(measurement, age),
                  color: cardColor,
                ),
                SizedBox(height: AppDimensions.spacingXS(context)),
                Text(
                  _formatDate(measurement.dateTime),
                  style: GoogleFonts.nunito(
                    fontSize: AppDimensions.fontSM(context),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: AppDimensions.fontSM(context) + AppDimensions.spacingXS(context) / 4,
                      fontWeight: FontWeight.w600,
                      color: cardColor,
                    ),
                  ),
                  SizedBox(width: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
                  Icon(
                    Icons.water_drop,
                    color: cardColor,
                    size: AppDimensions.iconSM(context),
                  ),
                ],
              ),
              if (hasNote) ...[
                SizedBox(height: AppDimensions.spacingXS(context)),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 130),
                  child: Text(
                    note,
                    style: GoogleFonts.nunito(
                      fontSize: AppDimensions.fontSM(context) + AppDimensions.spacingXS(context) / 4,
                      color: AppColors.textPrimary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.'
        '${dateTime.month.toString().padLeft(2, '0')}.'
        '${dateTime.year}  '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String? _readNote(Measurement m) {
    final note = m.note?.trim();
    if (note == null || note.isEmpty) return null;
    return note;
  }
}

class _StageBadge extends StatelessWidget {
  const _StageBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2,
        vertical: AppDimensions.spacingXS(context) / 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDimensions.spacingXS(context)),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: AppDimensions.fontXS(context),
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
