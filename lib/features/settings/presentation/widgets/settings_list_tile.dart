// Ayarlar ekranındaki tek bir menü öğesini gösteren tile widget'ı.

import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(
          AppDimensions.cardRadius(context) - AppDimensions.spacingXS(context) / 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(AppDimensions.spacingSM(context)),
          decoration: BoxDecoration(
            color: effectiveIconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context) / 2,
            ),
          ),
          child: Icon(
            icon,
            color: effectiveIconColor,
            size: AppDimensions.iconMD(context) - AppDimensions.spacingXS(context) / 2,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontSize: AppDimensions.fontMD(context),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.nunito(
            color: AppColors.textSecondary,
            fontSize: AppDimensions.fontSM(context),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
          size: AppDimensions.iconMD(context),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.cardRadius(context) - AppDimensions.spacingXS(context) / 2,
          ),
        ),
      ),
    );
  }
}
