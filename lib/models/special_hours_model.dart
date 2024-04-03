class SpecialHoursModel {
  final String date;
  final bool? isClosed;
  final bool isOvernight;
  final String startTime;
  final String endTime;

  SpecialHoursModel({
    required this.date,
    required this.isClosed,
    required this.isOvernight,
    required this.startTime,
    required this.endTime,
  });
}
