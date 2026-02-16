import 'package:flutter/material.dart';
import 'package:flutter_application_4/widget/weather_service.dart';


class CitySearchDelegate extends SearchDelegate<String> {
  final WeatherService service = WeatherService();

  /// Clear button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = "",
        ),
    ];
  }

  /// Back button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ""),
    );
  }

  /// When user presses search button on keyboard
  @override
  Widget buildResults(BuildContext context) {
    final cityName = query.trim();

    Future.microtask(() => close(context, cityName));

    return const SizedBox();
  }

  /// Suggestions while typing
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Search city"));
    }

    return FutureBuilder<List<String>>(
      future: service.fetchCitySuggestions(query),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No cities found"));
        }

        final cities = snapshot.data!;

        return ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {

            final displayText = cities[index];

            return ListTile(
              leading: const Icon(Icons.location_city),
              title: Text(displayText),
              onTap: () {
                close(context, displayText);   // return city
              },
            );
          },
        );
      },
    );
  }
}
