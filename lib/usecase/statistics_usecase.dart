import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:myapp/domain/statistics.dart';
import 'package:myapp/port/statistics_port.dart';
import 'package:myapp/presenter/statistics_presenter.dart';

@injectable
class StatisticsUsecase extends ChangeNotifier{
  final StatisticsPort _statisticsPort;
  final StasticsPresenter _presenter;

  StatisticsUsecase(this._statisticsPort, this._presenter);

  Future<void> find() async {
    final stastics = await _statisticsPort.find();
    _presenter.setAll(stastics);
  }

  Future<void> getHistories() async {
    final histories = await _statisticsPort.findAll();
    _presenter.setLineChart(histories);
  }
}