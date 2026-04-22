// Kullanıcı profilinin Hive veritabanında saklanması için kullanılan model.

import 'package:hive_flutter/hive_flutter.dart';

part 'user_profile_hive_model.g.dart';

@HiveType(typeId: 0)
class UserProfileHiveModel extends HiveObject {
  @HiveField(0)
  late DateTime birthDate;

  @HiveField(1)
  late double height;

  @HiveField(2)
  late double weight;

  @HiveField(3)
  late String gender;

  @HiveField(4)
  String? name;

  @HiveField(5)
  String? id;
}
