//import 'package:hive/hive.dart';
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormModelAdapter extends TypeAdapter<FormModel> {
  @override
  final int typeId = 0;

  @override
  FormModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormModel()
      ..amountOfMoney = fields[0] as double
      ..time = fields[1] as String
      ..motive = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, FormModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amountOfMoney)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.motive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
