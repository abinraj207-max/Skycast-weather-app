import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherService {
  static const String apiKey = "5640982ef620446186444644261302";

  Future<WeatherModel> fetchWeather(String city) async {
    final url =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=10";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future<WeatherModel> fetchWeatherByLatLon(double lat, double lon) async {
    final url =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat,$lon&days=10";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future<List<dynamic>> fetchTenDays(String city) async {
    final url =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=10";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["forecast"]["forecastday"];
    } else {
      throw Exception("Failed to load 10 day forecast");
    }
  }

  Future<List<String>> fetchCitySuggestions(String query) async {
    final url =
        "https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((city) {
        final name = city['name'];
        final region = city['region'];
        final country = city['country'];
        return "$name, $region, $country";
      }).toList();
    } else {
      throw Exception("Failed to fetch city suggestions");
    }
  }
}
