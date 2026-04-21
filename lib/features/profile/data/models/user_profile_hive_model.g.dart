// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileHiveModelAdapter extends TypeAdapter<UserProfileHiveModel> {
  @override
  final int typeId = 0;

  @override
  UserProfileHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileHiveModel()
      ..age = fields[0] as int
      ..height = fields[1] as double
      ..weight = fields[2] as double
      ..gender = fields[3] as String
      ..name = fields[4] as String?
      ..id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, UserProfileHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.age)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
