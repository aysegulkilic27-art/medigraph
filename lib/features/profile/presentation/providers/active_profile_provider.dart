import 'package:diyabetansiyon/core/constants/app_constants.dart';
import 'package:diyabetansiyon/features/profile/data/models/user_profile_hive_model.dart';
import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

class ActiveProfileNotifier extends StateNotifier<UserProfileHiveModel?> {
  ActiveProfileNotifier() : super(null);

  static const String _activeProfileKey = 'last_active_profile_id';

  Future<void> setActiveProfile(UserProfile profile) async {
    final box = Hive.box<UserProfileHiveModel>(AppConstants.profileBoxName);
    
    try {
      UserProfileHiveModel? hiveModel = box.values.cast<UserProfileHiveModel?>().firstWhere(
        (element) => element?.id == profile.id,
        orElse: () => null,
      );

      hiveModel ??= box.values.cast<UserProfileHiveModel?>().firstWhere(
          (element) => element?.name == profile.name && element?.birthDate == profile.birthDate,
          orElse: () => null,
        );

      if (hiveModel != null) {
        state = hiveModel;
        // Seçimi diske kaydet (Settings box'a)
        await Hive.box(AppConstants.settingsBoxName).put(_activeProfileKey, hiveModel.id);
        debugPrint('Aktif profil diske kaydedildi: ${hiveModel.name}');
      }
    } catch (e) {
      debugPrint('setActiveProfile Error: $e');
    }
  }

  Future<void> clearActiveProfile() async {
    state = null;
    await Hive.box(AppConstants.settingsBoxName).delete(_activeProfileKey);
  }
}

final activeProfileProvider = StateNotifierProvider<ActiveProfileNotifier, UserProfileHiveModel?>((ref) {
  return ActiveProfileNotifier();
});
