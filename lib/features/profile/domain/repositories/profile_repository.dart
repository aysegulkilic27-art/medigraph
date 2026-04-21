// Kullanıcı profili verilerine erişim için soyut repository arayüzü.

import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile?> getProfile();
  Future<void> saveProfile(UserProfile profile);
  Future<void> deleteProfile(String id);
  Future<List<UserProfile>> getAllProfiles();
}
