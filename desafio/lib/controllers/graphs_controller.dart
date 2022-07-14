import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphsController {
  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: 'Open Sans',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color(0xFFFD1A55),
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'HP';
        break;
      case 1:
        text = 'Attack';
        break;
      case 2:
        text = 'Defense';
        break;
      case 3:
        text = 'Speed';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  final _barsGradient = const LinearGradient(
    colors: [Color(0xFFFD1A55), Color.fromARGB(255, 255, 110, 149)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> barGroups(List<double> s) {
    List<BarChartGroupData> list = <BarChartGroupData>[];

    for (int i = 0; i < 4; i++) {
      list.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: s[i],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return list;
  }
}
