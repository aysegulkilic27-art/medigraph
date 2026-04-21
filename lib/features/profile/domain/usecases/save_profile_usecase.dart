// Kullanıcı profilini kaydeden veya güncelleyen use case.

import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/domain/repositories/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> execute(UserProfile profile) => repository.saveProfile(profile);
}
