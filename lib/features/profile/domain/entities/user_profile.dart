// Kullanıcının doğum tarihi, boy, kilo ve cinsiyet bilgilerini tutan entity.
// Eşik değer hesaplamalarında kullanılır.

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
  int get age {
    final today = DateTime.now();
    int calculatedAge = today.year - birthDate.year;
    
    // Doğum günü bu yıl henüz gelmemişse yaştan 1 çıkar
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      calculatedAge--;
    }
    
    return calculatedAge;
  }
}
