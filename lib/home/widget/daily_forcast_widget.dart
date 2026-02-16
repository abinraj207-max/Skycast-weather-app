import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/widget/daily_forecast_graph.dart';
import 'package:flutter_application_4/home/model/weather_model.dart';

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
    final Size size = MediaQuery.of(context).size;
    final List<double> weeklyTemps = weather.daily
        .map((e) => e.maxTemp)
        .toList();
    return Container(
      height: size.height * 0.2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.chipSelected,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month),
              SizedBox(width: size.width * 0.01),
              Text("Daily forecast"),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          DailyForecastGraph(weeklyTemps: weeklyTemps),
        ],
      ),
    );
  }
}
