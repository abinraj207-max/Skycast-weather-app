import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/search_pages.dart';
import 'package:flutter_application_4/home/tenday_page.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/theme/styles.dart';
import 'package:flutter_application_4/home/tomorrow_page.dart';
import 'package:flutter_application_4/home/widget/day_chip_widget.dart';
import 'package:flutter_application_4/home/widget/home_body_widget.dart';
import 'package:flutter_application_4/home/model/weather_model.dart';
import 'package:flutter_application_4/home/service/weather_service.dart';
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
    final spacing = lerpDouble(45, 1, progress) ?? 6;
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryStart, AppColors.primaryEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: isLoading || weather == null
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.chipUnselected),
            )
          : _buildHeaderContent(tempFont, spacing, size),
    );
  }

  Widget _buildHeaderContent(double tempFont, double spacing, Size size) {
    final temp = weather!.temp.round();
    final feels = weather!.feelsLike.round();
    final desc = weather!.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: spacing),

        Row(
          children: [
            Text(weather?.city ?? "", style: AppTextStyles.city),

            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.chipUnselected),
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
                color: AppColors.whiteText,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              "Feels like $feels°",
              style: const TextStyle(fontSize: 12, color: AppColors.whiteText),
            ),
            const Spacer(),
            Column(
              children: [
                Image.network(
                  weather!.icon,
                  width: size.width * 0.2,
                  height: size.height * 0.06,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.cloud, color: AppColors.whiteText),
                ),
                const SizedBox(height: 6),
                Text(desc, style: AppTextStyles.smallTemp),
              ],
            ),
          ],
        ),

        SizedBox(height: spacing),

        Text(formatDate(weather!.dateTime), style: AppTextStyles.normalWhite),

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
