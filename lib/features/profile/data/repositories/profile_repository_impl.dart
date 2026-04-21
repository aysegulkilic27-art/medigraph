// ProfileRepository arayüzünün Hive tabanlı gerçekleştirimi.

import 'package:diyabetansiyon/features/profile/data/models/user_profile_hive_model.dart';
import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/domain/repositories/profile_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

extension UserProfileHiveMapper on UserProfileHiveModel {
  UserProfile toEntity() => UserProfile(
    id: id ?? key?.toString(), // Eğer id null ise Hive key'ini kullan
    name: name,
    age: age,
    height: height,
    weight: weight,
    gender: gender,
  );
}

extension UserProfileMapper on UserProfile {
  UserProfileHiveModel toHiveModel() => UserProfileHiveModel()
    ..id = id
    ..name = name
    ..age = age
    ..height = height
    ..weight = weight
    ..gender = gender;
}

class ProfileRepositoryImpl implements ProfileRepository {
  final Box<UserProfileHiveModel> box;

  ProfileRepositoryImpl(this.box);

  @override
  Future<UserProfile?> getProfile() async {
    // Geriye dönük uyumluluk için 'current' anahtarına bak
    final current = box.get('current');
    if (current != null) return current.toEntity();
    
    // Yoksa ilk profili dön
    final profiles = await getAllProfiles();
    return profiles.isNotEmpty ? profiles.first : null;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    // Eğer ID yoksa yeni oluştur (Yeni kayıt durumu)
    final String targetId = profile.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    
    final hiveModel = profile.toHiveModel();
    hiveModel.id = targetId;
    
    // 'current' anahtarı varsa onu temizle (eski sistemden geçiş)
    if (box.containsKey('current')) {
      await box.delete('current');
    }
    
    // Benzersiz ID ile kaydet
    await box.put(targetId, hiveModel);
  }

  @override
  Future<void> deleteProfile(String id) async {
    await box.delete(id);
  }

  @override
  Future<List<UserProfile>> getAllProfiles() async {
    final List<UserProfile> profiles = [];
    
    for (var i = 0; i < box.length; i++) {
      final key = box.keyAt(i);
      if (key == 'current') continue; // Eski anahtarı atla
      
      final model = box.get(key);
      if (model != null) {
        // Modelin içindeki id alanı null ise key ile doldur ve güncelle
        if (model.id == null) {
          model.id = key.toString();
          await box.put(key, model);
        }
        profiles.add(model.toEntity());
      }
    }
    return profiles;
  }
}
