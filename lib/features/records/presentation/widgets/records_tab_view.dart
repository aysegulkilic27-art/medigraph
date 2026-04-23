import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/measurement_type.dart';
import 'package:diyabetansiyon/features/measurement/presentation/providers/measurement_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:diyabetansiyon/features/records/presentation/widgets/bp_record_card.dart';
import 'package:diyabetansiyon/features/records/presentation/widgets/sugar_record_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordsTabView extends ConsumerWidget {
  const RecordsTabView({required this.type, super.key});

  final MeasurementType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allMeasurements = ref.watch(allMeasurementsProvider);
    final profile = ref.watch(profileProvider).value;
    final age = profile?.age ?? 30;

    return allMeasurements.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (measurements) {
        final filtered = measurements.where((m) => m.type == type).toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type == MeasurementType.bloodPressure
                      ? Icons.favorite_outline
                      : Icons.water_drop_outlined,
                  color: AppColors.primary.withValues(alpha: 0.3),
                  size: AppDimensions.iconLG(context) + AppDimensions.spacingXL(context) / 2,
                ),
                SizedBox(height: AppDimensions.spacingSM(context) + AppDimensions.spacingXS(context)),
                Text(
                  AppTexts.noMeasurements,
                  style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontSize: AppDimensions.fontMD(context),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: AppDimensions.screenPadding(context),
          physics: const BouncingScrollPhysics(),
          itemCount: filtered.length,
          itemBuilder: (_, i) {
            final measurement = filtered[i];
            final card = type == MeasurementType.bloodPressure
                ? BpRecordCard(measurement: measurement, age: age)
                : SugarRecordCard(measurement: measurement, age: age);

            return Dismissible(
              key: ValueKey(measurement.id),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingMD(context),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.delete_outline, color: Colors.white),
                    SizedBox(width: AppDimensions.spacingXS(context)),
                    Text(
                      'Ölçümü Sil',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              onDismissed: (_) async {
                await ref
                    .read(measurementRepositoryProvider)
                    .deleteMeasurement(measurement.id);
                ref.invalidate(allMeasurementsProvider);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ölçüm silindi')),
                  );
                }
              },
              child: card,
            );
          },
        );
      },
    );
  }
}
