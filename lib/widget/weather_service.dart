import 'dart:convert';

import 'package:flutter_application_4/widget/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = "5640982ef620446186444644261302";
  static const String baseUrl = "https://api.weatherapi.com/v1/forecast.json";

  Future<WeatherModel> fetchWeatherByLatLon(double lat, double lon) async {
    final url =
        "https://api.weatherapi.com/v1/forecast.json?key=5640982ef620446186444644261302&q=$lat,$lon&days=10";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future<dynamic> fetchTenDays(String s) async {}
}
