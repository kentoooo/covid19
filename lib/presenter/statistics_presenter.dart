import 'package:injectable/injectable.dart';
import 'package:myapp/domain/statistics.dart';
import 'package:myapp/state/state.dart';

@injectable
class StasticsPresenter {
  final ViewState _state;

  StasticsPresenter(this._state);

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
}
