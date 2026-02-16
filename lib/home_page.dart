import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/search_pages.dart';
import 'package:flutter_application_4/tenday_page.dart';
import 'package:flutter_application_4/tomorrow_page.dart';
import 'package:flutter_application_4/widget/day_chip_widget.dart';
import 'package:flutter_application_4/widget/home_body_widget.dart';
import 'package:flutter_application_4/widget/weather_model.dart';
import 'package:flutter_application_4/widget/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weather;
  bool isLoading = true;
  int selectedDay = 0;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      setState(() => isLoading = true);

      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final service = WeatherService();

      final result = await service.fetchWeatherByLatLon(
        position.latitude,
        position.longitude,
      );

      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  Future<void> _openSearch() async {
    final selectedCity = await showSearch<String>(
      context: context,
      delegate: CitySearchDelegate(),
    );

    if (selectedCity != null && selectedCity.isNotEmpty) {
      loadWeatherByCity(selectedCity);
    }
  }

  Future<void> loadWeatherByCity(String city) async {
    try {
      setState(() => isLoading = true);

      final service = WeatherService();
      final result = await service.fetchWeather(city);

      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: WeatherHeaderDelegate(
              weather: weather,
              isLoading: isLoading,
              selectedDay: selectedDay,
              onDayChanged: (i) => setState(() => selectedDay = i),
              onSearchTap: _openSearch,
            ),
          ),

          SliverFillRemaining(hasScrollBody: true, child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading || weather == null) {
      return const SizedBox(
        height: 400,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (selectedDay == 0) {
      return WeatherBody(weather: weather!, isLoading: isLoading);
    } else if (selectedDay == 1) {
      return TomorrowPage(weather: weather!);
    } else {
      return TendayPage(daily: weather!.daily);
    }
  }
}

class WeatherHeaderDelegate extends SliverPersistentHeaderDelegate {
  final WeatherModel? weather;
  final bool isLoading;
  final int selectedDay;
  final ValueChanged<int> onDayChanged;
  final VoidCallback onSearchTap;

  WeatherHeaderDelegate({
    required this.selectedDay,
    required this.onDayChanged,
    required this.weather,
    required this.isLoading,
    required this.onSearchTap,
  });

  @override
  double get maxExtent => 480;

  @override
  double get minExtent => 260;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    final tempFont = lerpDouble(100, 30, progress) ?? 30;
    final spacing = lerpDouble(45, 6, progress) ?? 6;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 100, 66, 234),
            Color.fromARGB(255, 192, 64, 238),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: isLoading || weather == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _buildHeaderContent(tempFont, spacing),
    );
  }

  Widget _buildHeaderContent(double tempFont, double spacing) {
    final temp = weather!.temp.round();
    final feels = weather!.feelsLike.round();
    final desc = weather!.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: spacing),

        Row(
          children: [
            Text(
              weather?.city ?? "",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: onSearchTap,
            ),
          ],
        ),

        SizedBox(height: spacing),

        Row(
          children: [
            Text(
              "$temp°",
              style: TextStyle(
                fontSize: tempFont,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "Feels like $feels°",
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            const Spacer(),
            Column(
              children: [
                Image.network(
                  weather!.icon,
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.cloud, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: spacing),

        Text(
          formatDate(weather!.dateTime),
          style: const TextStyle(color: Colors.white),
        ),

        SizedBox(height: spacing),

        Row(
          children: [
            DayChip(
              text: "Today",
              selected: selectedDay == 0,
              onTap: () => onDayChanged(0),
            ),
            const Spacer(),
            DayChip(
              text: "Tomorrow",
              selected: selectedDay == 1,
              onTap: () => onDayChanged(1),
            ),
            const Spacer(),
            DayChip(
              text: "10 Days",
              selected: selectedDay == 2,
              onTap: () => onDayChanged(2),
            ),
          ],
        ),
      ],
    );
  }

  @override
  @override
  bool shouldRebuild(covariant WeatherHeaderDelegate oldDelegate) {
    return oldDelegate.weather != weather ||
        oldDelegate.isLoading != isLoading ||
        oldDelegate.selectedDay != selectedDay;
  }
}

String formatDate(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  return "${monthName(date.month)} ${date.day}, "
      "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
}

String monthName(int month) {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  return months[month - 1];
}
