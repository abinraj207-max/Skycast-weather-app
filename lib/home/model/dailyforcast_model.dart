class DailyForecastModel {
  final String date;
  final String dayName;
  final String condition;
  final double maxTemp;
  final double minTemp;
  final String icon;

  DailyForecastModel({
    required this.date,
    required this.dayName,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.icon,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date']);

    final dayNames = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun"
    ];

    return DailyForecastModel(
      date: json['date'],
      dayName: dayNames[date.weekday - 1],
      condition: json['day']['condition']['text'],
      maxTemp: (json['day']['maxtemp_c'] as num).toDouble(),
      minTemp: (json['day']['mintemp_c'] as num).toDouble(),
      icon: "https:${json['day']['condition']['icon']}",
    );
  }
}
