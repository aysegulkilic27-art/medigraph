// Kullanıcının yaş, boy, kilo ve cinsiyet bilgilerini tutan entity.
// Eşik değer hesaplamalarında kullanılır.

class UserProfile {
  final String? id;
  final String? name;
  final int age;
  final double height;
  final double weight;
  final String gender;

  const UserProfile({
    this.id,
    this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
  });
}
