import 'package:injectable/injectable.dart';
import 'package:myapp/domain/statistics.dart';
import 'package:myapp/state/line_chart.dart';
import 'package:myapp/state/state.dart';

@injectable
class StasticsPresenter {
  final ViewState _state;
  final LineChartModel _lineChartModel;

  StasticsPresenter(this._state, this._lineChartModel);

  void setAll(Statistics statistics) {
    _state.unit = StatisticsUnit(
        statistics.pcr,
        statistics.positive,
        statistics.discharge,
        statistics.hospitalize,
        statistics.severe,
        statistics.death);
    _state.updateComplete();
  }

  void setLineChart(List<Statistics> list) {
    _lineChartModel.item = list.map((e) => LineChartItem(e.pcr)).toList();
    _lineChartModel.notifyListeners();
  }
}
