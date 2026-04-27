import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileListScreen extends ConsumerWidget {
  const ProfileListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profil Seçin',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ref
          .watch(allProfilesProvider)
          .when(
            data: (profiles) {
              if (profiles.isEmpty) {
                return _buildEmptyState(context);
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(AppDimensions.spacingMD(context)),
                      itemCount: profiles.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppDimensions.spacingSM(context)),
                      itemBuilder: (context, index) {
                        final profile = profiles[index];
                        return Dismissible(
                          key: ValueKey(profile.id ?? 'profile_$index'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.cardRadius(context),
                              ),
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
                                  'Profili Sil',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onDismissed: (_) async {
                            final id = profile.id;
                            if (id == null) return;

                            await ref.read(profileRepositoryProvider).deleteProfile(id);

                            final active = ref.read(activeProfileProvider);
                            if (active?.id == id) {
                              await ref.read(activeProfileProvider.notifier).clearActiveProfile();
                            }

                            ref.invalidate(allProfilesProvider);
                            ref.invalidate(profileProvider);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Profil silindi')),
                              );
                            }
                          },
                          child: _ProfileCard(profile: profile),
                        );
                      },
                    ),
                  ),
                  _buildAddProfileButton(context),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Hata: $e')),
          ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          SizedBox(height: AppDimensions.spacingMD(context)),
          Text(
            'Henüz bir profil oluşturulmamış.',
            style: GoogleFonts.nunito(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingLG(context)),
          _buildAddProfileButton(context, isCompact: false),
        ],
      ),
    );
  }

  Widget _buildAddProfileButton(BuildContext context, {bool isCompact = true}) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.spacingMD(context)),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Yeni Profil Ekle'),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            double.infinity,
            AppDimensions.inputHeight(context),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.cardRadius(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends ConsumerWidget {
  final UserProfile profile;

  const _ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius(context)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMD(context),
          vertical: AppDimensions.spacingXS(context),
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.inputFill,
          child: Icon(
            (profile.gender == 'male' || profile.gender == 'Erkek')
                ? Icons.male
                : Icons.female,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          profile.name ?? 'İsimsiz Profil',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Yaş: ${profile.age} | ${profile.gender}',
          style: GoogleFonts.nunito(color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          try {
            await ref
                .read(activeProfileProvider.notifier)
                .setActiveProfile(profile);
            // State değiştiğinde MyApp home'u güncelleyecektir.
          } catch (e) {
            debugPrint('Profil seçim hatası: $e');
          }
        },
      ),
    );
  }
}
