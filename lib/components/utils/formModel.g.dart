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
      ..values = (fields[0] as Map)?.cast<String, dynamic>()
      ..image = fields[1] as dynamic;
  }

  @override
  void write(BinaryWriter writer, FormModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.values)
      ..writeByte(1)
      ..write(obj.image);
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
