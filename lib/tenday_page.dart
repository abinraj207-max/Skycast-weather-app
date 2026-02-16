import 'package:flutter/material.dart';
import 'package:flutter_application_4/dailyforcast_model.dart';

class TendayPage extends StatelessWidget {
  final List<DailyForecastModel> daily;

  const TendayPage({
    super.key,
    required this.daily,
  });

  @override
  Widget build(BuildContext context) {
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
              color: const Color(0xFFE9DDFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
              
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.dayName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.condition,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// TEMP
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${day.maxTemp.round()}°",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${day.minTemp.round()}°",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 10),

                /// ICON
                Image.network(
                  day.icon,
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
