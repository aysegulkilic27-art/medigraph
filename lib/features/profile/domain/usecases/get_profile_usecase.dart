// Kayıtlı kullanıcı profilini getiren use case.

import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserProfile?> execute() => repository.getProfile();
}
