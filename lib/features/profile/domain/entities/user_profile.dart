// Kullanıcının doğum tarihi, boy, kilo ve cinsiyet bilgilerini tutan entity.
// Eşik değer hesaplamalarında kullanılır.

import 'package:diyabetansiyon/core/utils/date_utils.dart';

class UserProfile {
  final String? id;
  final String? name;
  final DateTime birthDate;
  final double height;
  final double weight;
  final String gender;

  const UserProfile({
    this.id,
    this.name,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.gender,
  });

  /// Doğum tarihinden yaşı hesaplar
  int get age => AppDateUtils.calculateAge(birthDate);
}
