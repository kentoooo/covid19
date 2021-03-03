// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalJson _$TotalJsonFromJson(Map<String, dynamic> json) {
  return TotalJson(
    json['positive'] as int,
    json['date'] as int,
    json['pcr'] as int,
    json['hospitalize'] as int,
    json['severe'] as int,
    json['discharge'] as int,
    json['death'] as int,
    json['symptomConfirming'] as int,
  );
}

Map<String, dynamic> _$TotalJsonToJson(TotalJson instance) => <String, dynamic>{
      'positive': instance.positive,
      'date': instance.date,
      'pcr': instance.pcr,
      'hospitalize': instance.hospitalize,
      'severe': instance.severe,
      'discharge': instance.discharge,
      'death': instance.death,
      'symptomConfirming': instance.symptomConfirming,
    };
