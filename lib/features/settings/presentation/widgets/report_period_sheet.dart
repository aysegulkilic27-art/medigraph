// PDF rapor dönemi seçimi için bottom sheet widget'ı.
// Hazır seçenekler ve özel tarih aralığı desteği içerir.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/measurement/presentation/providers/measurement_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/report_period_option.dart';
import 'package:diyabetansiyon/services/pdf/pdf_report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportPeriodSheet extends ConsumerStatefulWidget {
  const ReportPeriodSheet({super.key});

  @override
  ConsumerState<ReportPeriodSheet> createState() => _ReportPeriodSheetState();
}

class _ReportPeriodSheetState extends ConsumerState<ReportPeriodSheet> {
  int _selectedIndex = 2;
  DateTimeRange? _customRange;
  bool _isLoading = false;

  final List<ReportPeriodOption> _options = reportPeriodOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppTexts.reportPeriodTitle,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_options.length, (i) {
            final opt = _options[i];
            final isSelected = _selectedIndex == i;

            return GestureDetector(
              onTap: () async {
                if (opt.days == null) {
                  final range = await showDateRangePicker(
                    context: context,
                    locale: const Locale('tr', 'TR'),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    initialDateRange: DateTimeRange(
                      start: DateTime.now().subtract(const Duration(days: 30)),
                      end: DateTime.now(),
                    ),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppColors.primary,
                          onPrimary: Colors.white,
                        ),
                      ),
                      child: child!,
                    ),
                  );

                  if (range != null) {
                    setState(() {
                      _selectedIndex = i;
                      _customRange = range;
                    });
                  }
                  return;
                }

                setState(() {
                  _selectedIndex = i;
                  _customRange = null;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textHint.withValues(alpha: 0.2),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      opt.icon,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        opt.label,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (opt.days == null && _customRange != null)
                      Text(
                        '${_formatDate(_customRange!.start)} - ${_formatDate(_customRange!.end)}',
                        style: GoogleFonts.nunito(
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 18,
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _generateReport,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.picture_as_pdf_rounded),
              label: Text(
                _isLoading
                    ? AppTexts.reportGenerating
                    : AppTexts.reportGenerate,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateReport() async {
    setState(() => _isLoading = true);
    try {
      final option = _options[_selectedIndex];
      final now = DateTime.now();

      final DateTimeRange range;
      if (option.days != null) {
        range = DateTimeRange(
          start: now.subtract(Duration(days: option.days!)),
          end: now,
        );
      } else if (_customRange != null) {
        range = _customRange!;
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(AppTexts.reportDateError)));
        setState(() => _isLoading = false);
        return;
      }

      final measurements = await ref.read(allMeasurementsProvider.future);
      final profile = ref.read(profileProvider).valueOrNull;

      if (!mounted) {
        return;
      }

      await PdfReportService.generateAndShare(
        context: context,
        allMeasurements: measurements,
        profile: profile,
        dateRange: range,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${AppTexts.reportError}: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.'
        '${dt.month.toString().padLeft(2, '0')}.'
        '${dt.year}';
  }
}
