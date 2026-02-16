import 'package:flutter/material.dart';
import 'package:flutter_application_4/widget/weather_model.dart';

class HourlyForecast extends StatelessWidget {
  final WeatherModel weather;
  const HourlyForecast({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(103, 155, 39, 176),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.timelapse_rounded),
              SizedBox(width: 10),
              Text("Hourly forecast"),
            ],
          ),
          const SizedBox(height: 10),
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
