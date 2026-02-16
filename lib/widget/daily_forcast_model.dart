class DailyForecastModel {
  final String dayName;
  final String condition;
  final double maxTemp;
  final double minTemp;
  final String icon;

  DailyForecastModel({
    required this.dayName,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.icon,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date']);

    const days = [
      "Mon","Tue","Wed","Thu","Fri","Sat","Sun"
    ];

    return DailyForecastModel(
      dayName: days[date.weekday - 1],
      condition: json['day']['condition']['text'],
      maxTemp: (json['day']['maxtemp_c'] as num).toDouble(),
      minTemp: (json['day']['mintemp_c'] as num).toDouble(),
      icon: "https:${json['day']['condition']['icon']}",
    );
  }
}
