// Ölçüm verisinin Hive veritabanında saklanması için kullanılan model.
// Measurement entity ile karşılıklı dönüşüm sağlar.

import 'package:hive_flutter/hive_flutter.dart';

part 'measurement_hive_model.g.dart';

@HiveType(typeId: 1)
class MeasurementHiveModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String type;

  @HiveField(2)
  late double value1;

  @HiveField(3)
  double? value2;

  @HiveField(4)
  bool? isFasting;

  @HiveField(5)
  late DateTime dateTime;

  @HiveField(7)
  String? note;

  @HiveField(8)
  String? profileId;
}
