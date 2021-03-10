import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/injector.dart';
import 'package:myapp/state/line_chart.dart';
import 'package:myapp/state/state.dart';
import 'package:myapp/usecase/statistics_usecase.dart';
import 'package:provider/provider.dart';

void main() async {
  configureDependencies();
  await getIt<StatisticsUsecase>().find();
  await getIt<StatisticsUsecase>().getHistories();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: MultiProvider(
          providers: [
            Provider(create: (_) => getIt<ViewState>()),
            Provider(create: (_) => getIt<LineChartModel>())
          ],
          child:Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff3D019D),
              ),
              backgroundColor: Color(0xff4E019C),
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    sliver: SliverToBoxAdapter(child: StatsGrid()),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    sliver: SliverToBoxAdapter(child: CovidLineChart()),
                  )
                ],
              ),
            ),
          ),
        );
  }
}

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ViewState>();
    return Container(
        height: 350,
        color: Color(0xff53019B),
        child: Column(
          children: [
            Flexible(
                child: Row(children: [
              _buildStatCard('感染者', state.unit!.positive, Color(0xffF9A354)),
            ])),
            Flexible(
                child: Row(children: [
              _buildStatCard('PCR検査', state.unit!.pcr, Color(0xff3ABC62)),
              _buildStatCard('回復者', state.unit!.discharge, Color(0xff43C8D9)),
            ])),
            Flexible(
                child: Row(children: [
              _buildStatCard('入院者', state.unit!.hospitalize, Color(0xffFECC49)),
              _buildStatCard('重傷者', state.unit!.severe, Color(0xffff6463)),
              _buildStatCard('死者', state.unit!.death, Color(0xff5302C1)),
            ]))
          ],
        ));
  }
}

Expanded _buildStatCard(String title, int count, Color color) => Expanded(
      child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  count.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ])),
    );

class CovidLineChart extends StatelessWidget {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LineChartModel>();
    return Column(
      children: [
        Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            color: Color(0xff232d37),
          ),
          child: Text(
            'PCR 検査数推移',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4),
            textAlign: TextAlign.center,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(state.item),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<LineChartItem> histories) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 100:
                return '2020/01';
              case 370:
                return '2021/03';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 3500000:
                return '350万';
              case 7000000:
                return '700万';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: histories.length.toDouble(),
      minY: 0,
      maxY: 8000000,
      lineBarsData: [
        LineChartBarData(
          spots: histories
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.pcr.toDouble()))
              .toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
