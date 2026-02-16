import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyForecastGraph extends StatelessWidget {
  final List<double> weeklyTemps;

  const DailyForecastGraph({super.key, required this.weeklyTemps});

  @override
  Widget build(BuildContext context) {
    if (weeklyTemps.isEmpty) {
      return const SizedBox(height: 90, child: Center(child: Text("No Data")));
    }

    return SizedBox(
      height: 90,
      child: LineChart(
        LineChartData(
          minY: weeklyTemps.reduce((a, b) => a < b ? a : b) - 2,
          maxY: weeklyTemps.reduce((a, b) => a > b ? a : b) + 2,
          maxX: weeklyTemps.length.toDouble() - 1,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                weeklyTemps.length,
                (i) => FlSpot(i.toDouble(), weeklyTemps[i]),
              ),
              isCurved: false,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
