class HourlyRain {
  final String time;
  final int chance;

  HourlyRain({
    required this.time,
    required this.chance,
  });

  factory HourlyRain.fromJson(Map<String, dynamic> json) {
    return HourlyRain(
      time: json['time'],
      chance: json['chance_of_rain'],
    );
  }
}
