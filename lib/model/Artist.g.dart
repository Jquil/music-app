// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist(
    json['country'] as String,
    json['artistFans'] as int,
    json['gener'] as String,
    json['pic'] as String,
    json['upPcUrl'] as String,
    json['pic120'] as String,
    json['aartist'] as String,
    json['name'] as String,
    json['info'] as String,
  );
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'country': instance.country,
      'artistFans': instance.artistFans,
      'gener': instance.gener,
      'pic': instance.pic,
      'upPcUrl': instance.upPcUrl,
      'pic120': instance.pic120,
      'aartist': instance.aartist,
      'name': instance.name,
      'info': instance.info,
    };
