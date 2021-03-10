import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class LineChartModel extends ChangeNotifier {
  List<LineChartItem> item = [];
}

class LineChartItem {
  final int pcr;
  LineChartItem(this.pcr);
}