import 'package:myapp/domain/statistics.dart';
import 'package:myapp/port/statistics_port.dart';

class StatisticsUsecase {
  Future<Statistics> find() async {
    final stastics = await StatisticsGateway().find();
    return stastics;
  }

  Future<List<Statistics>> getHistories() async {
    final histories = await StatisticsGateway().findAll();
    return histories;
  }
}