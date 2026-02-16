// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/theme/styles.dart';
import 'package:flutter_application_4/home/widget/chain_of_rain.dart';
import 'package:flutter_application_4/home/model/hourly_rain_model.dart';

class ChanceOfRain extends StatelessWidget {
  final List<HourlyRain> hourlyRain;

  const ChanceOfRain({super.key, required this.hourlyRain});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (hourlyRain.isEmpty) {
      return const Text("No rain data available");
    }

    final rainData = hourlyRain.take(4).toList();

    return Container(
      height: size.height*0.2,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.chipSelected,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop_outlined),
              SizedBox(width: size.width * 0.01),
              Text("Chance of rain", style: AppTextStyles.cardTitle),
            ],
          ),
          SizedBox(height: size.height * 0.01),

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
