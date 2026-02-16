import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/model/weather_model.dart';
import 'package:flutter_application_4/home/theme/colors.dart';

class HourlyForecast extends StatelessWidget {
  final WeatherModel weather;
  const HourlyForecast({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.chipSelected,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.timelapse_rounded),
              SizedBox(width: size.width * 0.01),
              Text("Hourly forecast"),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: List.generate(6, (i) {
              final now = DateTime.now();
              final hourTime = now.add(Duration(hours: i));

              return Expanded(
                child: Column(
                  children: [
                    Text(
                      "${hourTime.hour}:${hourTime.minute.toString().padLeft(2, '0')}",
                    ),

                    Image.network(weather.icon, width: 40, height: 40),

                    Text("${weather.temp.round()}°"),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
