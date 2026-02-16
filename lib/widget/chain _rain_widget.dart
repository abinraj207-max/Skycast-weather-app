// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_4/widget/chain_of_rain.dart';
import 'package:flutter_application_4/widget/hourly_rain_model.dart';

class ChanceOfRain extends StatelessWidget {
  final List<HourlyRain> hourlyRain;

  const ChanceOfRain({super.key, required this.hourlyRain});

  @override
  Widget build(BuildContext context) {
    if (hourlyRain.isEmpty) {
      return const Text("No rain data available");
    }

    final rainData = hourlyRain.take(4).toList();

    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(103, 155, 39, 176),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.water_drop_outlined),
              SizedBox(width: 6),
              Text(
                "Chance of rain",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...rainData.map(
            (hour) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: RainProgressRow(
                time: _formatHour(hour.time),
                percent: hour.chance,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatHour(String apiTime) {
    final date = DateTime.parse(apiTime);
    return "${date.hour % 12 == 0 ? 12 : date.hour % 12} ${date.hour >= 12 ? "PM" : "AM"}";
  }
}
