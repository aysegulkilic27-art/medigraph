// Açlık ve tokluk şekeri arasında geçiş sağlayan toggle widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FastingToggle extends StatelessWidget {
  const FastingToggle({
    super.key,
    required this.isFasting,
    required this.onChanged,
  });

  final bool isFasting;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(
          AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [AppTexts.fasting, AppTexts.postMeal].asMap().entries.map((entry) {
          final selected = isFasting == (entry.key == 0);
          return GestureDetector(
            onTap: () => onChanged(entry.key == 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingLG(context) - AppDimensions.spacingXS(context),
                vertical: AppDimensions.spacingSM(context),
              ),
              decoration: BoxDecoration(
                color: selected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(AppDimensions.spacingSM(context)),
              ),
              child: Text(
                entry.value,
                style: GoogleFonts.nunito(
                  fontSize: AppDimensions.fontSM(context),
                  color: selected ? AppColors.accentBlue : Colors.white,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
