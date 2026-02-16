import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/model/dailyforcast_model.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/theme/styles.dart';

class TendayPage extends StatelessWidget {
  final List<DailyForecastModel> daily;

  const TendayPage({super.key, required this.daily});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (daily.isEmpty) {
      return const Center(child: Text("No forecast data"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: daily.length,
      itemBuilder: (context, index) {
        final day = daily[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(day.dayName, style: AppTextStyles.cardTitle),
                    SizedBox(height: size.height * 0.01),
                    Text(day.condition, style: AppTextStyles.smallcardTitle),
                  ],
                ),

                const Spacer(),

                /// TEMP
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${day.maxTemp.round()}°",
                      style: AppTextStyles.cardTitle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${day.minTemp.round()}°",
                      style: AppTextStyles.smallcardTitle,
                    ),
                  ],
                ),

                SizedBox(width: size.width * 0.03),

                /// ICON
                Image.network(day.icon, width: 40, height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
