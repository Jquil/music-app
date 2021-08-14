// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    json['sourceid'] as String,
    json['pic'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'sourceid': instance.sourceid,
      'pic': instance.pic,
      'name': instance.name,
    };
