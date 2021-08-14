import 'package:demo/db/TBBank.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Bank.g.dart';

@JsonSerializable()
class Bank{

  @JsonKey(name: "sourceid")
  String sourceid;

  @JsonKey(name: "pic")
  String pic;

  @JsonKey(name: "name")
  String name;

  Bank(this.sourceid,this.pic,this.name);

  factory Bank.fromJson(Map<String,dynamic> json) => _$BankFromJson(json);
  Map<String,dynamic> toJson() => _$BankToJson(this);

  Map<String,dynamic> toMap(){
    return{
      TBBank.CM_SOUCEID:sourceid,
      TBBank.CM_IMG:pic,
      TBBank.CM_NAME:name
    };
  }

  // flutter pub run build_runner build
}