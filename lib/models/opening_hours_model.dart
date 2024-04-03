class OpeningHoursModel {
  final bool isOvernight;
  final String startTime;
  final String endTime;
  final int dayOfWeek;

  OpeningHoursModel({
    required this.isOvernight,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
  });
}
