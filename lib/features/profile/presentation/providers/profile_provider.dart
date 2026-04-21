// Kullanıcı profili verisini Riverpod ile yöneten provider.

import 'package:diyabetansiyon/core/constants/app_constants.dart';
import 'package:diyabetansiyon/features/profile/data/models/user_profile_hive_model.dart';
import 'package:diyabetansiyon/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/domain/repositories/profile_repository.dart';
import 'package:diyabetansiyon/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:diyabetansiyon/features/profile/domain/usecases/save_profile_usecase.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
Box<UserProfileHiveModel> profileBox(ProfileBoxRef ref) {
  return Hive.box<UserProfileHiveModel>(AppConstants.profileBoxName);
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl(ref.watch(profileBoxProvider));
}

@riverpod
GetProfileUseCase getProfileUseCase(GetProfileUseCaseRef ref) {
  return GetProfileUseCase(ref.watch(profileRepositoryProvider));
}

@riverpod
SaveProfileUseCase saveProfileUseCase(SaveProfileUseCaseRef ref) {
  return SaveProfileUseCase(ref.watch(profileRepositoryProvider));
}

@riverpod
Future<UserProfile?> profile(ProfileRef ref) async {
  final activeProfile = ref.watch(activeProfileProvider);
  if (activeProfile == null) return null;
  
  return UserProfile(
    id: activeProfile.id,
    name: activeProfile.name,
    age: activeProfile.age,
    height: activeProfile.height,
    weight: activeProfile.weight,
    gender: activeProfile.gender,
  );
}

@riverpod
Future<List<UserProfile>> allProfiles(AllProfilesRef ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getAllProfiles();
}
