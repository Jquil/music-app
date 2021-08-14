import 'package:demo/db/TBCollectList.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Song.g.dart';

@JsonSerializable()
class Song{

  @JsonKey(name: "musicrid")
  String musicrid;

  // 歌手
  @JsonKey(name: "artist")
  String artist;

  // 歌手id
  @JsonKey(name: "artistid")
  int artistid;

  // 歌名
  @JsonKey(name: "name")
  String name;

  // 专辑
  @JsonKey(name: "album")
  String album;

  // 专辑照片
  @JsonKey(name: "albumpic")
  String albumpic;

  // 歌曲时长
  @JsonKey(name: "songTimeMinutes")
  String songTimeMinutes;

  // 是否有MV : 1,
  @JsonKey(name: "hasmv")
  int hasmv;

  Song(this.name,this.album,this.albumpic,this.artist,this.artistid,this.hasmv,this.musicrid,this.songTimeMinutes);

  factory Song.fromJson(Map<String,dynamic> json) => _$SongFromJson(json);
  Map<String,dynamic> toJson() => _$SongToJson(this);

  Map<String,dynamic> toMap(){
    return{
      TBCollectList.CM_MUSICRID:musicrid,
      TBCollectList.CM_ARTIST:artist,
      TBCollectList.CM_ARTISTID:artistid,
      TBCollectList.CM_NAME:name,
      TBCollectList.CM_ALBUM:album,
      TBCollectList.CM_ALBUMPIC:albumpic,
      TBCollectList.CM_SONGTIMEMINUTES:songTimeMinutes,
      TBCollectList.CM_HASMV:hasmv
    };
  }
  // flutter pub run build_runner build
}