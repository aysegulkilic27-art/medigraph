// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileBoxHash() => r'56bc9cab134d6b9a9fc2d85ff65b2890097c9afc';

/// See also [profileBox].
@ProviderFor(profileBox)
final profileBoxProvider =
    AutoDisposeProvider<Box<UserProfileHiveModel>>.internal(
  profileBox,
  name: r'profileBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$profileBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfileBoxRef = AutoDisposeProviderRef<Box<UserProfileHiveModel>>;
String _$profileRepositoryHash() => r'e5fefa79f60a17dc17ec6fa062ca23fcf7ab7985';

/// See also [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
  profileRepository,
  name: r'profileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
String _$getProfileUseCaseHash() => r'f31e08c20f14aecedfe9a2f7a166c2c259fc7471';

/// See also [getProfileUseCase].
@ProviderFor(getProfileUseCase)
final getProfileUseCaseProvider =
    AutoDisposeProvider<GetProfileUseCase>.internal(
  getProfileUseCase,
  name: r'getProfileUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getProfileUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetProfileUseCaseRef = AutoDisposeProviderRef<GetProfileUseCase>;
String _$saveProfileUseCaseHash() =>
    r'ad0096876356f0308c943959a517895feab9c2ba';

/// See also [saveProfileUseCase].
@ProviderFor(saveProfileUseCase)
final saveProfileUseCaseProvider =
    AutoDisposeProvider<SaveProfileUseCase>.internal(
  saveProfileUseCase,
  name: r'saveProfileUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveProfileUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SaveProfileUseCaseRef = AutoDisposeProviderRef<SaveProfileUseCase>;
String _$profileHash() => r'e39e3334b19f2586a2844fdaac1a77d2bd753cf4';

/// See also [profile].
@ProviderFor(profile)
final profileProvider = AutoDisposeFutureProvider<UserProfile?>.internal(
  profile,
  name: r'profileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$profileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfileRef = AutoDisposeFutureProviderRef<UserProfile?>;
String _$allProfilesHash() => r'74092b4c0684b5ef96cfd47b4ff9a928e8d8cff0';

/// See also [allProfiles].
@ProviderFor(allProfiles)
final allProfilesProvider =
    AutoDisposeFutureProvider<List<UserProfile>>.internal(
  allProfiles,
  name: r'allProfilesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allProfilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllProfilesRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
