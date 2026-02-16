import 'package:flutter/material.dart';
import 'package:flutter_application_4/widget/daily_forecast_graph.dart';
import 'package:flutter_application_4/widget/weather_model.dart';

class DailyForecast extends StatelessWidget {
  final String dayName;
  final String condition;
  final double maxTemp;
  final double minTemp;
  final String icon;
  final WeatherModel weather;
  const DailyForecast({
    super.key,
    required this.dayName,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.icon,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final List<double> weeklyTemps = weather.daily
        .map((e) => e.maxTemp)
        .toList();
    return Container(
      height: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(103, 155, 39, 176),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_month),
              SizedBox(width: 10),
              Text("Daily forecast"),
            ],
          ),
          const SizedBox(height: 10),
          DailyForecastGraph(weeklyTemps: weeklyTemps),
        ],
      ),
    );
  }
}
