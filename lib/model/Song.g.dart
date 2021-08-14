// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song(
    json['name'] as String,
    json['album'] as String,
    json['albumpic'] as String,
    json['artist'] as String,
    json['artistid'] as int,
    json['hasmv'] as int,
    json['musicrid'] as String,
    json['songTimeMinutes'] as String,
  );
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'musicrid': instance.musicrid,
      'artist': instance.artist,
      'artistid': instance.artistid,
      'name': instance.name,
      'album': instance.album,
      'albumpic': instance.albumpic,
      'songTimeMinutes': instance.songTimeMinutes,
      'hasmv': instance.hasmv,
    };
