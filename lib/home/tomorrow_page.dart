import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/model/weather_model.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/theme/styles.dart';

class TomorrowPage extends StatelessWidget {
  final WeatherModel weather;

  const TomorrowPage({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Tomorrow", style: AppTextStyles.cardValue),
                    SizedBox(height: size.height * 0.0),
                    Text(
                      weather.tomorrowCondition,
                      style: AppTextStyles.smallcardTitle,
                    ),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${weather.tomorrowMaxTemp.round()}°",
                      style: AppTextStyles.cardValue,
                    ),
                    Text(
                      "${weather.tomorrowMinTemp.round()}°",
                      style: AppTextStyles.smallcardTitle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
