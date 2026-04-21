// Toplam ölçüm, eşik aşımı ve ortalama gibi istatistikleri
// gösteren renkli özet kart widget'ı.

import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    required this.icon,
    required this.gradient,
  });

  final String label;
  final String value;
  final String? unit;
  final IconData icon;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(AppDimensions.cardPadding(context) - AppDimensions.spacingXS(context) / 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: AppDimensions.iconMD(context) - 2),
            SizedBox(height: AppDimensions.spacingSM(context) - AppDimensions.spacingXS(context) / 2),
            Text(
              value,
              style: GoogleFonts.spaceMono(
                color: Colors.white,
                fontSize: AppDimensions.fontLG(context) + AppDimensions.spacingXS(context) / 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (unit != null)
              Text(
                unit!,
                style: GoogleFonts.nunito(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: AppDimensions.fontXS(context),
                ),
              ),
            Text(
              label,
              style: GoogleFonts.nunito(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: AppDimensions.fontXS(context) + AppDimensions.spacingXS(context) / 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

