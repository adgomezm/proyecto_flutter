// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escaperoom.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EscapeRoomAdapter extends TypeAdapter<EscapeRoom> {
  @override
  final int typeId = 0;

  @override
  EscapeRoom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EscapeRoom()
      ..id = fields[0] as int
      ..nombre = fields[1] as String
      ..ciudad = fields[2] as String
      ..precio = fields[3] as double
      ..dificultad = fields[4] as int
      ..tiempo = fields[5] as String
      ..tematica = fields[6] as String
      ..empresa = fields[7] as String
      ..descripcion = fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, EscapeRoom obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.ciudad)
      ..writeByte(3)
      ..write(obj.precio)
      ..writeByte(4)
      ..write(obj.dificultad)
      ..writeByte(5)
      ..write(obj.tiempo)
      ..writeByte(6)
      ..write(obj.tematica)
      ..writeByte(7)
      ..write(obj.empresa)
      ..writeByte(8)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EscapeRoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
