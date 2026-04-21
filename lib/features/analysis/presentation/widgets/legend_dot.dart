import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegendDot extends StatelessWidget {
  const LegendDot({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
          height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: AppDimensions.spacingXS(context)),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: AppDimensions.fontXS(context) + AppDimensions.spacingXS(context) / 4,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
