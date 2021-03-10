import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ViewState extends ChangeNotifier with State {
  @override
  void updateComplete() {
    notifyListeners();
  }

  StatisticsUnit? unit;
}
class StatisticsUnit {
  final int pcr;
  final int positive;
  final int discharge;
  final int hospitalize;
  final int severe;
  final int death;

  StatisticsUnit(this.pcr, this.positive, this.discharge, this.hospitalize, this.severe, this.death);
}

abstract class State {
  void updateComplete();
}