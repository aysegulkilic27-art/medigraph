import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteDataButton extends StatelessWidget {
  const DeleteDataButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.inputHeight(context),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: const BorderSide(color: AppColors.accent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.cardRadius(context) - AppDimensions.spacingXS(context) / 2,
            ),
          ),
        ),
        icon: Icon(
          Icons.delete_outline_rounded,
          size: AppDimensions.iconMD(context),
        ),
        label: Text(
          AppTexts.deleteData,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: AppDimensions.fontMD(context),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
