import 'package:json_annotation/json_annotation.dart';

part 'total_json.g.dart';

@JsonSerializable()
class TotalJson {
  final int positive;

  final int date;
  final int pcr;
  final int hospitalize;
  final int severe;
  final int discharge;
  final int death;
  final int symptomConfirming;

  TotalJson(this.positive, this.date, this.pcr, this.hospitalize, this.severe,
      this.discharge, this.death, this.symptomConfirming);

  factory TotalJson.fromJson(Map<String, dynamic> json) =>
      _$TotalJsonFromJson(json);
}
