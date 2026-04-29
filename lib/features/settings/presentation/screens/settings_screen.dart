// Profil güncelleme, PDF rapor alma ve veri silme işlemlerini
// barındıran ayarlar ekranı.

import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/widgets/gradient_app_bar.dart';
import 'package:diyabetansiyon/core/widgets/health_background.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/screens/profile_list_screen.dart';
import 'package:diyabetansiyon/features/profile/presentation/screens/profile_screen.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/age_warning_banner.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/clinical_references_card.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/delete_data_button.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/delete_data_dialog.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/report_period_sheet.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GradientAppBar(title: AppTexts.settingsTitle),
      body: HealthBackground(
        child: SafeArea(
          top: false,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: AppDimensions.screenPadding(context),
            children: [
              const AgeWarningBanner(),
              SizedBox(
                height:
                    AppDimensions.spacingMD(context) -
                    AppDimensions.spacingXS(context) / 2,
              ),
              const ClinicalReferencesCard(),
              SizedBox(height: AppDimensions.spacingMD(context)),
              profileAsync.when(
                data: (p) => SettingsListTile(
                  title: AppTexts.updateProfile,
                  subtitle: p == null
                      ? AppTexts.noProfile
                      : AppTexts.updateProfileSub,
                  icon: Icons.manage_accounts_outlined,
                  onTap: p == null
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProfileScreen(initialProfile: p),
                            ),
                          );
                        },
                ),
                loading: () => Padding(
                  padding: EdgeInsets.all(AppDimensions.cardPadding(context)),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
                error: (e, _) => Text(
                  '${AppTexts.errorPrefix}: $e',
                  style: GoogleFonts.nunito(color: AppColors.statusHigh),
                ),
              ),
              SizedBox(height: AppDimensions.spacingMD(context)),
              SettingsListTile(
                icon: Icons.picture_as_pdf_rounded,
                title: AppTexts.pdfReport,
                subtitle: AppTexts.pdfReportSub,
                iconColor: AppColors.accent,
                onTap: () => _showReportBottomSheet(context),
              ),
              SizedBox(height: AppDimensions.spacingMD(context)),
              SettingsListTile(
                icon: Icons.switch_account_outlined,
                title: AppTexts.switchProfile,
                subtitle: AppTexts.switchProfileSub,
                iconColor: AppColors.primary,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => ProfileListScreen()),
                    (route) => false,
                  );
                },
              ),
              SizedBox(height: AppDimensions.spacingMD(context)),
              DeleteDataButton(onTap: () => showDeleteDataDialog(context, ref)),
            ],
          ),
        ),
      ),
    );
  }
}

void _showReportBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const ReportPeriodSheet(),
  );
}
