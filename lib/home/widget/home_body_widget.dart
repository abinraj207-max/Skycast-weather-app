import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/widget/chain%20_rain_widget.dart';
import 'package:flutter_application_4/home/model/weather_model.dart';

import 'daily_forcast_widget.dart';
import 'hourly_forcast_widget.dart';
import 'info_card_widget.dart';

class WeatherBody extends StatelessWidget {
  final WeatherModel weather;
  final bool isLoading;

  const WeatherBody({
    super.key,
    required this.weather,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.01),

              Row(
                children: [
                  InfoCard(
                    icon: Icons.air,
                    title: "Wind Speed",
                    value: "${weather.windSpeed} m/s",
                    change: "Live",
                  ),
                  const Spacer(),
                  InfoCard(
                    icon: Icons.water_drop_outlined,
                    title: "Rain Chance",
                    value: "-- %",
                    change: "",
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              Row(
                children: [
                  InfoCard(
                    icon: Icons.waves,
                    title: "Pressure",
                    value: "${weather.pressure} hpa",
                    change: "Normal",
                  ),
                  const Spacer(),
                  InfoCard(
                    icon: Icons.wb_sunny_outlined,
                    title: "UV Index",
                    value: weather.uv.toStringAsFixed(1),
                    change: _uvLevel(weather.uv),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              HourlyForecast(weather: weather),

              SizedBox(height: size.height * 0.02),
              DailyForecast(
                dayName: '',
                condition: '',
                maxTemp: 0.0,
                minTemp: 0.0,
                icon: '',
                weather: weather,
              ),

              SizedBox(height: size.height * 0.02),
              ChanceOfRain(hourlyRain: weather.hourlyRain),

              SizedBox(height: size.height * 0.02),

              Row(
                children: [
                  InfoCard(
                    icon: Icons.wb_sunny_outlined,
                    title: "Sunrise",
                    value: weather.sunrise,
                    change: "",
                  ),
                  const Spacer(),
                  InfoCard(
                    icon: Icons.sunny_snowing,
                    title: "Sunset",
                    value: weather.sunset,
                    change: "",
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ],
    );
  }

  String _uvLevel(double uv) {
    if (uv <= 2) return "Low";
    if (uv <= 5) return "Moderate";
    if (uv <= 7) return "High";
    if (uv <= 10) return "Very High";
    return "⚠ Extreme";
  }
}
