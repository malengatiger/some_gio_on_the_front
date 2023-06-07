// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_for_upload.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioForUploadAdapter extends TypeAdapter<AudioForUpload> {
  @override
  final int typeId = 35;

  @override
  AudioForUpload read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioForUpload(
      filePath: fields[0] as String?,
      projectId: fields[1] as String?,
      projectName: fields[2] as String?,
      position: fields[3] as Position?,
      audioId: fields[5] as String?,
      userId: fields[6] as String?,
      userName: fields[7] as String?,
      userThumbnailUrl: fields[9] as String?,
      organizationId: fields[8] as String?,
      durationInSeconds: fields[10] as int?,
      fileBytes: fields[11] as Uint8List?,
      date: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AudioForUpload obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.projectId)
      ..writeByte(2)
      ..write(obj.projectName)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.audioId)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.userName)
      ..writeByte(8)
      ..write(obj.organizationId)
      ..writeByte(9)
      ..write(obj.userThumbnailUrl)
      ..writeByte(10)
      ..write(obj.durationInSeconds)
      ..writeByte(11)
      ..write(obj.fileBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioForUploadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
