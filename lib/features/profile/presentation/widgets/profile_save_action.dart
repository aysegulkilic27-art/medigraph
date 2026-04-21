// Profil formunu doğrulayıp kaydeden aksiyon widget'ı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> saveProfileForm({
  required BuildContext context,
  required WidgetRef ref,
  required GlobalKey<FormState> formKey,
  required TextEditingController nameController,
  required TextEditingController ageController,
  required TextEditingController heightController,
  required TextEditingController weightController,
  required String? gender,
  required UserProfile? initialProfile,
  required VoidCallback? onSaved,
  required void Function(bool) setSaving,
}) async {
  final formState = formKey.currentState;
  if (formState == null || !formState.validate()) return;
  formState.save();

  final age = int.tryParse(ageController.text.trim());
  final height = double.tryParse(heightController.text.trim());
  final weight = double.tryParse(weightController.text.trim());
  if (age == null || height == null || weight == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppTexts.invalidProfile)));
    }
    return;
  }

  final g = gender;
  if (g == null) return;

  setSaving(true);
  try {
    final profile = UserProfile(
      id: initialProfile?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim().isEmpty
          ? null
          : nameController.text.trim(),
      age: age,
      height: height,
      weight: weight,
      gender: g,
    );
    await ref.read(saveProfileUseCaseProvider).execute(profile);
    
    // Listeyi ve aktif profili güncelle
    ref.invalidate(allProfilesProvider);
    
    // Eğer bu yeni bir profilse (id yoksa) veya tek profilse aktif yap
    await ref.read(activeProfileProvider.notifier).setActiveProfile(profile);
    
    if (!context.mounted) return;
    onSaved?.call();
    Navigator.of(context).pop();
  } finally {
    setSaving(false);
  }
}
