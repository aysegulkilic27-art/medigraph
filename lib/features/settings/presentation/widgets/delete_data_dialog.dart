// Tüm verilerin silinmesi için onay diyaloğu widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/measurement/presentation/providers/measurement_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showDeleteDataDialog(BuildContext context, WidgetRef ref) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        AppTexts.deleteConfirmTitle,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: AppDimensions.fontLG(context),
        ),
      ),
      content: Text(
        AppTexts.deleteConfirmBody,
        style: GoogleFonts.nunito(fontSize: AppDimensions.fontMD(context)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            AppTexts.confirmNo,
            style: GoogleFonts.nunito(fontSize: AppDimensions.fontSM(context)),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.accent),
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            AppTexts.confirmYes,
            style: GoogleFonts.nunito(fontSize: AppDimensions.fontSM(context)),
          ),
        ),
      ],
    ),
  );
  if (confirmed == true) {
    try {
      await ref.read(deleteAllMeasurementsUseCaseProvider).execute();
      ref.invalidate(allMeasurementsProvider);
      ref.invalidate(measurementRepositoryProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppTexts.dataDeleted,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: AppColors.statusNormal,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius(context),
              ),
            ),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppTexts.deleteError,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: AppColors.statusHigh,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius(context),
              ),
            ),
          ),
        );
      }
    }
  }
}
