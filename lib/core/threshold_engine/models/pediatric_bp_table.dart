// AAP 2017 kılavuzuna göre çocuk ve ergen için yaşa/cinsiyete özel
// sistolik ve diyastolik persentil eşik değerlerini içeren tablo.

class PediatricBpEntry {
  final int ageLow;
  final int ageHigh;
  final bool isMale;
  final int sys50p;
  final int sys95p;
  final int dia50p;
  final int dia95p;

  const PediatricBpEntry({
    required this.ageLow,
    required this.ageHigh,
    required this.isMale,
    required this.sys50p,
    required this.sys95p,
    required this.dia50p,
    required this.dia95p,
  });
}

const List<PediatricBpEntry> pediatricBpTable = [
  PediatricBpEntry(
    ageLow: 1,
    ageHigh: 2,
    isMale: true,
    sys50p: 85,
    sys95p: 100,
    dia50p: 40,
    dia95p: 55,
  ),
  PediatricBpEntry(
    ageLow: 3,
    ageHigh: 5,
    isMale: true,
    sys50p: 89,
    sys95p: 104,
    dia50p: 47,
    dia95p: 63,
  ),
  PediatricBpEntry(
    ageLow: 6,
    ageHigh: 9,
    isMale: true,
    sys50p: 95,
    sys95p: 109,
    dia50p: 54,
    dia95p: 68,
  ),
  PediatricBpEntry(
    ageLow: 10,
    ageHigh: 12,
    isMale: true,
    sys50p: 100,
    sys95p: 115,
    dia50p: 59,
    dia95p: 74,
  ),
  PediatricBpEntry(
    ageLow: 13,
    ageHigh: 15,
    isMale: true,
    sys50p: 108,
    sys95p: 123,
    dia50p: 62,
    dia95p: 77,
  ),
  PediatricBpEntry(
    ageLow: 16,
    ageHigh: 17,
    isMale: true,
    sys50p: 114,
    sys95p: 129,
    dia50p: 64,
    dia95p: 79,
  ),
  PediatricBpEntry(
    ageLow: 1,
    ageHigh: 2,
    isMale: false,
    sys50p: 84,
    sys95p: 100,
    dia50p: 40,
    dia95p: 55,
  ),
  PediatricBpEntry(
    ageLow: 3,
    ageHigh: 5,
    isMale: false,
    sys50p: 88,
    sys95p: 103,
    dia50p: 47,
    dia95p: 63,
  ),
  PediatricBpEntry(
    ageLow: 6,
    ageHigh: 9,
    isMale: false,
    sys50p: 94,
    sys95p: 108,
    dia50p: 55,
    dia95p: 69,
  ),
  PediatricBpEntry(
    ageLow: 10,
    ageHigh: 12,
    isMale: false,
    sys50p: 100,
    sys95p: 114,
    dia50p: 60,
    dia95p: 74,
  ),
  PediatricBpEntry(
    ageLow: 13,
    ageHigh: 15,
    isMale: false,
    sys50p: 106,
    sys95p: 120,
    dia50p: 63,
    dia95p: 78,
  ),
  PediatricBpEntry(
    ageLow: 16,
    ageHigh: 17,
    isMale: false,
    sys50p: 108,
    sys95p: 122,
    dia50p: 64,
    dia95p: 79,
  ),
];

PediatricBpEntry? getPediatricEntry(int age, bool isMale) {
  try {
    return pediatricBpTable.firstWhere(
      (e) => e.ageLow <= age && age <= e.ageHigh && e.isMale == isMale,
    );
  } catch (_) {
    return null;
  }
}
