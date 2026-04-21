// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasurementHiveModelAdapter extends TypeAdapter<MeasurementHiveModel> {
  @override
  final int typeId = 1;

  @override
  MeasurementHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeasurementHiveModel()
      ..id = fields[0] as String
      ..type = fields[1] as String
      ..value1 = fields[2] as double
      ..value2 = fields[3] as double?
      ..isFasting = fields[4] as bool?
      ..dateTime = fields[5] as DateTime
      ..note = fields[7] as String?
      ..profileId = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, MeasurementHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.value1)
      ..writeByte(3)
      ..write(obj.value2)
      ..writeByte(4)
      ..write(obj.isFasting)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(7)
      ..write(obj.note)
      ..writeByte(8)
      ..write(obj.profileId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
