// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_books_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateBooksModelAdapter extends TypeAdapter<CreateBooksModel> {
  @override
  final int typeId = 1;

  @override
  CreateBooksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateBooksModel(
      serverId: fields[4] as int?,
      localId: fields[5] as int?,
      title: fields[0] as String,
      author: fields[1] as String,
      description: fields[2] as String,
      createdAt: fields[3] as DateTime,
      coverPath: fields[6] as String?,
      isSynced: fields[8] as bool?,
      coverUrl: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CreateBooksModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.serverId)
      ..writeByte(5)
      ..write(obj.localId)
      ..writeByte(6)
      ..write(obj.coverPath)
      ..writeByte(7)
      ..write(obj.coverUrl)
      ..writeByte(8)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateBooksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
