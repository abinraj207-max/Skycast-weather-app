import 'package:flutter/material.dart';
import 'package:flutter_application_4/widget/weather_model.dart';

class TomorrowPage extends StatelessWidget {
  final WeatherModel weather;

  const TomorrowPage({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE9DDFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Tomorrow",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  weather.tomorrowCondition,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),

            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${weather.tomorrowMaxTemp.round()}°",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${weather.tomorrowMinTemp.round()}°",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
