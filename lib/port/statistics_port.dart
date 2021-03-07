import 'package:injectable/injectable.dart';
import 'package:myapp/domain/statistics.dart';
import 'package:myapp/driver/covid19_api.dart';

import '../total_json.dart';

abstract class StatisticsPort {
  Future<Statistics> find();
  Future<List<Statistics>> findAll();
}

@Injectable(as: StatisticsPort)
class StatisticsGateway implements StatisticsPort {
  @override
  Future<Statistics> find() async {
    final response = await Covid19Api().totalCount();
    return _toStatistics(response);
  }

  @override
  Future<List<Statistics>> findAll() async {
    final response = await Covid19Api().requestTotalHistory();
    final histories = response.map((e) => _toStatistics(e)).toList();
    return histories;
  }

  Statistics _toStatistics(TotalJson json) => Statistics(json.date.toString(), json.pcr, json.positive, json.discharge, json.hospitalize, json.severe, json.death);

}