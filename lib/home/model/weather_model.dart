import 'package:flutter_application_4/home/model/dailyforcast_model.dart';
import 'package:flutter_application_4/home/model/hourly_rain_model.dart';

class WeatherModel {
  final String city;
  final double temp;
  final double feelsLike;
  final int humidity;
  final String description;
  final int dateTime;
  final String timezone;
  final String sunrise;
  final String sunset;
  final double windSpeed;
  final double pressure;
  final double minTemp;
  final String icon;
  final int conditionCode;
  final double uv;
  final List<DailyForecastModel> daily;
  final List<double> weeklyTemps;
  final List<HourlyRain> hourlyRain;
  final double tomorrowMaxTemp;
  final double tomorrowMinTemp;
  final String tomorrowCondition;
  final String tomorrowIcon;

  WeatherModel({
    required this.city,
    required this.temp,
    required this.feelsLike,

    required this.humidity,
    required this.description,
    required this.dateTime,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.pressure,
    required this.minTemp,
    required this.icon,
    required this.conditionCode,
    required this.uv,
    required this.daily,
    required this.weeklyTemps,
    required this.hourlyRain,
    required this.tomorrowMaxTemp,
    required this.tomorrowMinTemp,
    required this.tomorrowCondition,
    required this.tomorrowIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final dailyList = (json['forecast']['forecastday'] as List)
        .map((e) => DailyForecastModel.fromJson(e))
        .toList();
    (json['forecast']['forecastday'] as List)
        .map<double>((day) => (day['day']['maxtemp_c'] as num).toDouble())
        .toList();
    (json['forecast']['forecastday'][0]['hour'] as List)
        .map((e) => HourlyRain.fromJson(e))
        .toList();

    return WeatherModel(
      city: json['location']['name'] ?? '',
      timezone: json['location']['tz_id'] ?? '',
      dateTime: json['location']['localtime_epoch'] ?? 0,

      temp: (json['current']['temp_c'] as num).toDouble(),
      feelsLike: (json['current']['feelslike_c'] as num).toDouble(),
      windSpeed: (json['current']['wind_kph'] as num).toDouble(),
      humidity: (json['current']['humidity'] as num).toInt(),
      pressure: (json['current']['pressure_mb'] as num).toDouble(),
      description: json['current']['condition']['text'] ?? '',

      minTemp: (json['forecast']['forecastday'][0]['day']['mintemp_c'] as num)
          .toDouble(),

      sunrise: json['forecast']['forecastday'][0]['astro']['sunrise'] ?? '',
      sunset: json['forecast']['forecastday'][0]['astro']['sunset'] ?? '',
      icon: "https:${json['current']['condition']['icon']}",
      conditionCode: json['current']['condition']['code'],
      uv: (json['current']['uv'] as num?)?.toDouble() ?? 0.0,

      daily: dailyList,
      weeklyTemps: [],
      hourlyRain: [],
      tomorrowMaxTemp:
          (json['forecast']['forecastday'][1]['day']['maxtemp_c'] as num)
              .toDouble(),
      tomorrowMinTemp:
          (json['forecast']['forecastday'][1]['day']['mintemp_c'] as num)
              .toDouble(),
      tomorrowCondition:
          json['forecast']['forecastday'][1]['day']['condition']['text'],
      tomorrowIcon:
          "https:${json['forecast']['forecastday'][1]['day']['condition']['icon']}",
    );
  }
}
