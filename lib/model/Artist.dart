import 'package:json_annotation/json_annotation.dart';
part 'Artist.g.dart';
@JsonSerializable()
class Artist{

  //@JsonKey(name: "birthday")
  //String birthday;

  @JsonKey(name: "country")
  String country;

  @JsonKey(name: "artistFans")
  int artistFans;

  @JsonKey(name: "gener")
  String gener;

  //@JsonKey(name: "weight")
  //String weight;

  //@JsonKey(name: "language")
  //String language;

  @JsonKey(name: "pic")
  String pic;

  @JsonKey(name: "upPcUrl")
  String upPcUrl;

  @JsonKey(name: "pic120")
  String pic120;

  @JsonKey(name: "aartist")
  String aartist;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "info")
  String info;



  Artist( this.country, this.artistFans, this.gener,
       this.pic, this.upPcUrl, this.pic120, this.aartist,
      this.name, this.info);

  factory Artist.fromJson(Map<String,dynamic> json) => _$ArtistFromJson(json);
  Map<String,dynamic> toArtist() => _$ArtistToJson(this);
}